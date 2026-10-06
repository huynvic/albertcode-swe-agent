# AlbertCode SWE Agent bootstrap for Windows.
#
#   irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 | iex
#
# Options go in ALBERTCODE_INSTALL_ARGS, because `| iex` cannot pass arguments:
#
#   $env:ALBERTCODE_INSTALL_ARGS = '--check'; irm .../install.ps1 | iex
#
# It downloads the Windows installer from a release of this repository, checks it against that
# release's SHA256SUMS, and runs it. It changes nothing itself: the installer checks the machine,
# shows its plan and asks "Proceed? [Y/N]" before it changes anything.
#
# --uninstall removes AlbertCode instead, after showing what it will remove and asking.
#
# Written for Windows PowerShell 5.1, which every Windows 10 and 11 has. Under `| iex` it runs in
# your own PowerShell window, so it never calls `exit`: that would close the window.

$Repository = 'huynvic/albertcode-swe-agent'

function Write-Problem([string]$text, [string]$detail = '') {
    Write-Host "AlbertCode bootstrap: $text" -ForegroundColor Red
    if ($detail) { Write-Host $detail }
}

function Get-Downloads {
    # A mirror of the releases, laid out as GitHub lays them out. Unset means this repository's.
    if ($env:ALBERTCODE_DOWNLOAD_BASE) { return $env:ALBERTCODE_DOWNLOAD_BASE.TrimEnd('/') }
    return "https://github.com/$Repository/releases"
}

function Read-Options([string[]]$words) {
    $options = [ordered]@{ Version = ''; Uninstall = $false; Yes = $false; Check = $false; Reinstall = $false; Help = $false; Problem = '' }
    for ($i = 0; $i -lt $words.Count; $i++) {
        $word = $words[$i]
        switch -regex ($word) {
            '^--version$' {
                if ($i + 1 -ge $words.Count) { $options.Problem = '--version needs a version, for example --version 1.35.0'; return $options }
                $i++; $options.Version = $words[$i] }
            '^--version=' { $options.Version = $word.Substring(10) }
            '^--uninstall$' { $options.Uninstall = $true }
            '^(--yes|-y)$' { $options.Yes = $true }
            '^--check$' { $options.Check = $true }
            '^--reinstall$' { $options.Reinstall = $true }
            '^(--help|-h)$' { $options.Help = $true }
            default { $options.Problem = "unknown option: $word"; return $options }
        }
    }
    $options.Version = $options.Version -replace '^v', ''
    if ($options.Version -and $options.Version -notmatch '^[0-9][0-9A-Za-z.+-]*$') { $options.Problem = "not a version: $($options.Version)" }
    return $options
}

function Get-File([string]$url, [string]$path) {
    # WebClient follows redirects, uses the system proxy, and works the same on 5.1 and 7.
    $client = New-Object System.Net.WebClient
    $client.Headers.Add('User-Agent', 'albertcode-bootstrap')
    try { $client.DownloadFile($url, $path) } finally { $client.Dispose() }
}

function Get-Sha256([string]$path) {
    $sha = [System.Security.Cryptography.SHA256]::Create()
    $stream = [System.IO.File]::OpenRead($path)
    try { return ([System.BitConverter]::ToString($sha.ComputeHash($stream)) -replace '-', '').ToLowerInvariant() }
    finally { $stream.Dispose(); $sha.Dispose() }
}

# The installer named in a SHA256SUMS file, as @{ File; Version; Sha256 }, or $null. The one built
# for Windows x64 is preferred (it also runs on ARM, under Windows' own emulation); one without a
# platform in its name runs anywhere.
function Find-Installer([string]$sums, [string]$suffix) {
    $lines = @(Get-Content -LiteralPath $sums)
    foreach ($platform in @('-windows-x64', '')) {
        foreach ($line in $lines) {
            $match = [regex]::Match($line, "^([0-9a-fA-F]{64}) [ *]?(Install-AlbertCode-([0-9][0-9A-Za-z.+]*)$platform\.$suffix)$")
            if ($match.Success) {
                return @{ Sha256 = $match.Groups[1].Value.ToLowerInvariant(); File = $match.Groups[2].Value; Version = $match.Groups[3].Value }
            }
        }
    }
    return $null
}

# Download the installer for this release and check it. Returns its path, or $null after saying why.
function Get-Installer($options, [string]$work, [string]$suffix = 'cmd') {
    $downloads = Get-Downloads
    $sumsUrl = if ($options.Version) { "$downloads/download/v$($options.Version)/SHA256SUMS" } else { "$downloads/latest/download/SHA256SUMS" }
    $sums = Join-Path $work 'SHA256SUMS'
    Write-Host 'Finding the AlbertCode release for Windows...'
    try { Get-File $sumsUrl $sums } catch {
        if ($options.Version) { Write-Problem "release $($options.Version) was not found." "Releases: https://github.com/$Repository/releases" }
        else { Write-Problem 'no release could be downloaded.' "Check your connection (behind a proxy, set HTTPS_PROXY), or see https://github.com/$Repository/releases" }
        return $null
    }
    $found = Find-Installer $sums $suffix
    if (-not $found) { Write-Problem 'the release has no installer for Windows.'; return $null }
    if ($options.Version -and $found.Version -ne $options.Version) {
        Write-Problem "release $($options.Version) lists an installer for $($found.Version); refusing the mismatch."; return $null
    }
    $path = Join-Path $work $found.File
    Write-Host "Downloading $($found.File)..."
    try { Get-File "$downloads/download/v$($found.Version)/$($found.File)" $path } catch {
        Write-Problem 'the installer could not be downloaded.' "Try again, or download it from https://github.com/$Repository/releases"
        return $null
    }
    $actual = Get-Sha256 $path
    if ($actual -ne $found.Sha256) {
        Remove-Item -LiteralPath $path -Force -ErrorAction SilentlyContinue
        Write-Problem 'the downloaded installer does not match its published checksum. Nothing was run.' `
            "Expected $($found.Sha256), got $actual. Try again; if it keeps happening, report it: https://github.com/$Repository/security"
        return $null
    }
    Write-Host "Checked $($found.File) against the release's SHA-256."
    return $path
}

function Invoke-Uninstall($options) {
    $root = Join-Path $env:LOCALAPPDATA 'AlbertCode'
    $settings = Join-Path $env:LOCALAPPDATA 'AlbertCode SWE Agent'
    $uv = $null
    if (Test-Path -LiteralPath (Join-Path $root 'bin\uv.exe')) { $uv = Join-Path $root 'bin\uv.exe' }
    elseif (Get-Command uv -ErrorAction SilentlyContinue) { $uv = (Get-Command uv).Source }
    $withUv = $false
    if ($uv) { $withUv = [bool](& $uv tool list 2>$null | Select-String -Pattern '^albertcode ' -Quiet) }
    $pipx = Get-Command pipx -ErrorAction SilentlyContinue
    $withPipx = $false
    if ($pipx) { $withPipx = [bool](& $pipx.Source list --short 2>$null | Select-String -Pattern '^albertcode ' -Quiet) }
    $launcher = Get-Command albertcode -ErrorAction SilentlyContinue

    Write-Host ''
    Write-Host 'AlbertCode uninstall'
    Write-Host 'Nothing is changed until you say so.'
    Write-Host ''
    if (-not $withUv -and -not $withPipx -and -not (Test-Path -LiteralPath $root)) {
        if ($launcher) { Write-Host "AlbertCode is at $($launcher.Source), but it was not installed by the AlbertCode installer, uv or pipx. Remove it the way it was installed." }
        else { Write-Host 'AlbertCode is not installed.' }
        return
    }
    $plan = @()
    if ($launcher) { $plan += 'Stop the AlbertCode service, if it is running.' }
    if ($withUv) { $plan += 'Remove AlbertCode (installed with uv).' }
    if ($withPipx) { $plan += 'Remove AlbertCode (installed with pipx).' }
    if (Test-Path -LiteralPath $root) { $plan += "Remove the installer's files in $root." }
    Write-Host 'Will do'
    for ($i = 0; $i -lt $plan.Count; $i++) { Write-Host ("  {0}. {1}" -f ($i + 1), $plan[$i]) }
    Write-Host ''
    Write-Host "Kept: your settings, saved keys and task history, in $settings."
    Write-Host 'Delete that folder yourself if you want them gone.'
    Write-Host ''
    if ($options.Check) { return }
    if (-not $options.Yes) {
        Write-Host 'Proceed? [Y/N] ' -NoNewline
        $answer = Read-Host
        if ($answer -notmatch '^(y|yes)$') { Write-Host 'Nothing was changed.'; return }
    }
    if ($launcher) { & $launcher.Source stop *> $null }
    if ($withUv) {
        & $uv tool uninstall albertcode *> $null
        if ($LASTEXITCODE -ne 0) { Write-Problem 'uv could not remove AlbertCode.' "Try: & '$uv' tool uninstall albertcode"; return }
        Write-Host '  Removed AlbertCode.'
    }
    if ($withPipx) {
        & $pipx.Source uninstall albertcode *> $null
        if ($LASTEXITCODE -ne 0) { Write-Problem 'pipx could not remove AlbertCode.' 'Try: pipx uninstall albertcode'; return }
        Write-Host '  Removed AlbertCode (pipx).'
    }
    if (Test-Path -LiteralPath $root) {
        Remove-Item -LiteralPath $root -Recurse -Force
        Write-Host "  Removed $root."
    }
    $left = Get-Command albertcode -ErrorAction SilentlyContinue
    if ($left -and (Test-Path -LiteralPath $left.Source)) {
        Write-Host "albertcode is still at $($left.Source). It was installed some other way; remove it the way it was installed." -ForegroundColor Yellow
    } else {
        Write-Host 'AlbertCode is uninstalled.' -ForegroundColor Green
    }
}

function Invoke-Bootstrap([string[]]$words) {
    $options = Read-Options $words
    if ($options.Problem) { Write-Problem $options.Problem; return }
    if ($options.Help) {
        Write-Host 'Options (in ALBERTCODE_INSTALL_ARGS): --check, --yes, --reinstall, --version X.Y.Z, --uninstall'
        return
    }
    $onWindows = ($env:OS -eq 'Windows_NT')
    if (-not $onWindows) {
        Write-Problem 'this is the Windows bootstrap.' "On macOS and Linux, run: curl -fsSL https://raw.githubusercontent.com/$Repository/main/installer/install.sh | sh"
        return
    }
    # Windows PowerShell 5.1 may still offer only TLS 1.0, which GitHub refuses.
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

    if ($options.Uninstall) { Invoke-Uninstall $options; return }

    $work = Join-Path ([IO.Path]::GetTempPath()) ('albertcode-bootstrap-' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $work | Out-Null
    try {
        $installer = Get-Installer $options $work
        if (-not $installer) { return }
        $pass = @()
        if ($options.Yes) { $pass += '--yes' }
        if ($options.Check) { $pass += '--check' }
        if ($options.Reinstall) { $pass += '--reinstall' }
        # The installer is a .cmd; it asks its own question in this window.
        $run = if ($pass.Count) { Start-Process -FilePath $installer -ArgumentList $pass -NoNewWindow -Wait -PassThru }
               else { Start-Process -FilePath $installer -NoNewWindow -Wait -PassThru }
        if ($run.ExitCode -ne 0) { Write-Host "The installer stopped (exit code $($run.ExitCode)). What it printed above says why." }
    } finally {
        Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue
    }
}

if (-not $env:ALBERTCODE_BOOTSTRAP_NO_MAIN) {
    $words = @()
    if ($env:ALBERTCODE_INSTALL_ARGS) {
        $words += ($env:ALBERTCODE_INSTALL_ARGS -split '\s+' | Where-Object { $_ })
        # Used once: left set, a later install command in this window would repeat these options.
        Remove-Item Env:ALBERTCODE_INSTALL_ARGS -ErrorAction SilentlyContinue
    }
    if ($args) { $words += $args }
    Invoke-Bootstrap $words
}
