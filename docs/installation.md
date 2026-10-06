# Installation

## Quick install

| System | Command |
|---|---|
| macOS, Linux | `curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh \| sh` |
| Windows | `irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 \| iex` |

The command downloads a small bootstrap script from this repository. The bootstrap finds the
latest release, downloads the installer for your system, and checks it against the release's
published SHA-256 checksums. Then it runs the installer. If the checksum doesn't match, it stops
before running anything.

Prefer to read before running? Download [`installer/install.sh`](../installer/install.sh) or
[`installer/install.ps1`](../installer/install.ps1), read it, then run it.

## What the installer does

1. **Checks, changing nothing.** It looks for an existing AlbertCode and its version, a running
   AlbertCode service, a suitable Python, Git, a browser for the browser tools, free disk space,
   and whether it can reach the package index.
2. **Shows its plan and asks `Proceed? [Y/N]`.** If you answer N, nothing changes.
3. **Installs, for your user only.**
   - It downloads what is missing first, so a failed download leaves an existing installation
     untouched.
   - It stops and replaces an older AlbertCode.
   - It installs AlbertCode in an environment of its own, so your other Python projects are
     unaffected.
   - It adds the `albertcode` command to your PATH.
4. **Verifies.** It checks the version and the commands. Then it starts the service once on a spare
   port, using a scratch folder, and waits for it to answer.

Administrator rights are needed only if Git is missing: the installer uses winget on Windows and
your package manager (with `sudo`) on Linux.

## Options

Pass options to the bootstrap after `-s --` on macOS and Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh -s -- --check
```

On Windows, set them in `ALBERTCODE_INSTALL_ARGS` before running the command:

```powershell
$env:ALBERTCODE_INSTALL_ARGS = '--check'; irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 | iex
```

| Option | Meaning |
|---|---|
| *(none)* | Check, show the plan, ask, install |
| `--check` | Only check and show the plan |
| `--yes` | Install without asking (scripts, CI) |
| `--reinstall` | Install again even when this version is already installed |
| `--version X.Y.Z` | Install that release instead of the latest |
| `--uninstall` | Remove AlbertCode (see below) |

## Updating

Run the install command again. It finds the installed version, shows what will change, and
replaces it.

macOS and Linux (Terminal):

```bash
curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh
```

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 | iex
```

Saved provider keys and model choices are cleared the first time a new version starts. Connect your
model again with `/connect`.

## Uninstalling

From version 1.33.2, on any system:

```
albertcode uninstall
```

`--all` also removes your settings, saved keys and task history; `--check` only shows the plan.
It needs nothing from the internet. Or, with any version:

macOS and Linux (Terminal):

```bash
curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh -s -- --uninstall
```

Windows (PowerShell):

```powershell
$env:ALBERTCODE_INSTALL_ARGS = '--uninstall'; irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 | iex
```

The uninstaller lists what it will remove and asks first. It stops the service, removes the
`albertcode` program, and removes the installer's own files.

It keeps your settings and task history, and tells you where they are, so you can delete them
yourself if you want them gone.

## Manual download

Every [release](https://github.com/huynvic/albertcode-swe-agent/releases) lists the installer for
each system, plus a `SHA256SUMS` file:

| System | File | Run it with |
|---|---|---|
| Windows | `Install-AlbertCode-<version>-windows-x64.cmd` | Double-click, or run it from a terminal |
| Mac with Apple silicon | `Install-AlbertCode-<version>-macos-arm64.zip` | Open the zip, then double-click the installer inside |
| Mac with Intel | `Install-AlbertCode-<version>-macos-x86_64.zip` | Open the zip, then double-click the installer inside |
| Linux (x86-64) | `Install-AlbertCode-<version>-linux-x86_64.sh` | `bash Install-AlbertCode-<version>-linux-x86_64.sh` |

An installer for the wrong processor stops before changing anything and says which one to use.
There is no Linux installer for ARM processors yet.

The Mac installer is also in each release as a bare `.command` file, which the one-line command
uses. Download the `.zip` instead: a browser saves a bare `.command` without permission to run,
so double-clicking it says it "could not be executed because you do not have appropriate access
privileges". If that happens, run it from Terminal instead:

```bash
bash ~/Downloads/Install-AlbertCode-<version>-macos-arm64.command
```

Check a download before running it:

```bash
sha256sum -c SHA256SUMS --ignore-missing          # Linux
shasum -a 256 -c SHA256SUMS --ignore-missing      # macOS
```

```powershell
(Get-FileHash .\Install-AlbertCode-<version>-windows-x64.cmd -Algorithm SHA256).Hash   # Windows; compare with SHA256SUMS
```

## Unsigned installers

The installers are not yet code-signed, which the [roadmap](../ROADMAP.md) covers. Until they are:

- **Windows SmartScreen** may say it protected your PC. Choose *More info* → *Run anyway*.
- **macOS Gatekeeper** says it can't verify the installer is free of malware. Choose *Done*, open
  **System Settings → Privacy & Security**, scroll down, and click **Open Anyway** next to the
  installer's name. Then open the installer again and confirm. You only do this once.

The one-line install command avoids both warnings, because nothing is downloaded through a
browser.

Check the checksum first if you downloaded the file by hand.

## Requirements

| | |
|---|---|
| Windows | Windows 10 or 11 |
| macOS | A current version of macOS, on Apple silicon or Intel |
| Linux | A glibc-based distribution such as Ubuntu, Debian, Fedora, openSUSE or Arch. Alpine and other musl systems are not supported. |
| Disk | About 1 GB free |
| Network | Access to the package index while installing, and to your model provider while working |

You don't need to install Python yourself. AlbertCode runs on Python 3.12: the installer uses yours
if you have 3.12, and otherwise downloads it for AlbertCode alone.

## Networks that inspect encrypted traffic

Some workplaces check encrypted traffic with their own certificate. If a download fails because of
that certificate, the installer says so in one line and tries again using your computer's trusted
certificates.

If you use a proxy, set `HTTPS_PROXY` before installing.
