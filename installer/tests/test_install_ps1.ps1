# Tests for installer/install.ps1, against a fake release laid out as GitHub lays one out.
#
#   pwsh -NoProfile -File installer/tests/test_install_ps1.ps1
#
# Runs anywhere PowerShell does; on Windows it also runs the whole bootstrap against a fake .cmd
# installer. Nothing is installed.

$ErrorActionPreference = 'Stop'
$env:ALBERTCODE_BOOTSTRAP_NO_MAIN = '1'
. (Join-Path $PSScriptRoot '..\install.ps1')
Remove-Item Env:ALBERTCODE_BOOTSTRAP_NO_MAIN

$script:failed = 0
# A folder as a file:// address. [Uri] gives one for a Windows path, but not for a Unix path.
function ConvertTo-FileUri([string]$path) {
    if ($env:OS -eq 'Windows_NT') { return ([Uri]$path).AbsoluteUri }
    return 'file://' + $path
}
function Check([string]$name, [bool]$condition) {
    if ($condition) { Write-Output "ok    $name" } else { Write-Output "FAIL  $name"; $script:failed = 1 }
}

$work = Join-Path ([IO.Path]::GetTempPath()) ('albertcode-ps-test-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $work | Out-Null
try {
    # -- options -------------------------------------------------------------------------- #
    $o = Read-Options @('--check', '--version', 'v1.2.3')
    Check 'options: --check and --version' ($o.Check -and $o.Version -eq '1.2.3' -and -not $o.Problem)
    Check 'options: --version=X' ((Read-Options @('--version=2.0.0')).Version -eq '2.0.0')
    Check 'options: an unknown option is refused' ((Read-Options @('--frobnicate')).Problem -like 'unknown option*')
    Check 'options: a malformed version is refused' ((Read-Options @('--version', '1.0;rm')).Problem -like 'not a version*')
    Check 'options: --version needs a value' ((Read-Options @('--version')).Problem -like '*needs a version*')

    # -- a fake release ------------------------------------------------------------------- #
    function New-Release([string]$root, [string]$version, [string]$body) {
        $dir = Join-Path $root "download/v$version"
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
        $file = "Install-AlbertCode-$version.cmd"
        Set-Content -LiteralPath (Join-Path $dir $file) -Value $body -NoNewline
        "$(Get-Sha256 (Join-Path $dir $file))  $file" | Set-Content -LiteralPath (Join-Path $dir 'SHA256SUMS')
        return $dir
    }
    $mirror = Join-Path $work 'mirror'
    $record = Join-Path $work 'installer-args.txt'
    $body = "@echo off`r`necho %* > `"$record`"`r`n"
    New-Release $mirror '9.8.6' $body | Out-Null
    $latest = New-Release $mirror '9.8.7' $body
    New-Item -ItemType Directory -Force -Path (Join-Path $mirror 'latest/download') | Out-Null
    Copy-Item (Join-Path $latest 'SHA256SUMS') (Join-Path $mirror 'latest/download/SHA256SUMS')
    $env:ALBERTCODE_DOWNLOAD_BASE = ConvertTo-FileUri $mirror
    if ($env:ALBERTCODE_DOWNLOAD_BASE -notlike 'file://*') { throw 'the test mirror is not a file:// address' }

    $sums = Join-Path $latest 'SHA256SUMS'
    $found = Find-Installer $sums 'cmd'
    Check 'SHA256SUMS: finds the Windows installer' ($found.File -eq 'Install-AlbertCode-9.8.7.cmd' -and $found.Version -eq '9.8.7')
    Check 'SHA256SUMS: no installer for another suffix' ($null -eq (Find-Installer $sums 'sh'))
    $mixed = Join-Path $work 'mixed-SHA256SUMS'
    @("$('a' * 64)  Install-AlbertCode-9.9.0-linux-x86_64.sh", "$('b' * 64)  Install-AlbertCode-9.9.0-windows-x64.cmd") | Set-Content -LiteralPath $mixed
    $picked = Find-Installer $mixed 'cmd'
    Check 'SHA256SUMS: picks the Windows x64 build' ($picked.File -eq 'Install-AlbertCode-9.9.0-windows-x64.cmd' -and $picked.Version -eq '9.9.0' -and $picked.Sha256 -eq ('b' * 64))

    $dl = Join-Path $work 'dl1'; New-Item -ItemType Directory -Path $dl | Out-Null
    $path = Get-Installer (Read-Options @()) $dl 6>$null
    Check 'downloads and checks the latest installer' ($path -and (Split-Path $path -Leaf) -eq 'Install-AlbertCode-9.8.7.cmd')

    $dl = Join-Path $work 'dl2'; New-Item -ItemType Directory -Path $dl | Out-Null
    $path = Get-Installer (Read-Options @('--version', '9.8.6')) $dl 6>$null
    Check '--version picks that release' ($path -and (Split-Path $path -Leaf) -eq 'Install-AlbertCode-9.8.6.cmd')

    $dl = Join-Path $work 'dl3'; New-Item -ItemType Directory -Path $dl | Out-Null
    $path = Get-Installer (Read-Options @('--version', '1.0.0')) $dl 6>$null
    Check 'an unknown version gives nothing to run' ($null -eq $path)

    # A changed installer is refused, and removed.
    Add-Content -LiteralPath (Join-Path $latest 'Install-AlbertCode-9.8.7.cmd') -Value 'echo TAMPERED'
    $dl = Join-Path $work 'dl4'; New-Item -ItemType Directory -Path $dl | Out-Null
    $path = Get-Installer (Read-Options @()) $dl 6>$null
    Check 'a changed installer is refused' ($null -eq $path)
    Check 'and is not left behind' (-not (Test-Path (Join-Path $dl 'Install-AlbertCode-9.8.7.cmd')))

    $env:ALBERTCODE_DOWNLOAD_BASE = ConvertTo-FileUri (Join-Path $work 'nothing')
    $dl = Join-Path $work 'dl5'; New-Item -ItemType Directory -Path $dl | Out-Null
    Check 'no release gives nothing to run' ($null -eq (Get-Installer (Read-Options @()) $dl 6>$null))

    if ($env:OS -eq 'Windows_NT') {
        # The whole bootstrap, handing over to the (untampered) older release's .cmd.
        $env:ALBERTCODE_DOWNLOAD_BASE = ConvertTo-FileUri $mirror
        Invoke-Bootstrap @('--check', '--version', '9.8.6') 6>$null
        Check 'Windows: runs the installer with the options' ((Test-Path $record) -and ((Get-Content $record -Raw).Trim() -eq '--check'))
    } else {
        $said = Invoke-Bootstrap @() 6>&1 | Out-String
        Check 'elsewhere: points to the macOS and Linux bootstrap' ($said -like '*install.sh*')
    }
} finally {
    Remove-Item Env:ALBERTCODE_DOWNLOAD_BASE -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue
}

if ($script:failed) { Write-Output 'some tests failed'; exit 1 }
Write-Output 'all passed'
