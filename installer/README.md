# Installer bootstrap

The one-line install commands run these scripts:

| File | Runs on | Started by |
|---|---|---|
| [`install.sh`](install.sh) | macOS, Linux | `curl -fsSL …/installer/install.sh \| sh` |
| [`install.ps1`](install.ps1) | Windows (PowerShell 5.1 or 7) | `irm …/installer/install.ps1 \| iex` |

A bootstrap is small on purpose. It:

1. finds the release (the latest, or the one given with `--version`);
2. downloads that release's `SHA256SUMS` and the installer for this system;
3. checks the installer against its checksum, and stops if it doesn't match;
4. runs the installer, which checks the machine, shows its plan and asks before changing anything.

`--uninstall` is handled by the bootstrap itself. It shows its plan and asks first, stops the
service, removes AlbertCode and the installer's files, and keeps the user's settings.

User-facing documentation is in [docs/installation.md](../docs/installation.md).

## What a release must contain

The bootstrap expects each release to be tagged `v<version>`, with an installer per system and
processor, and their checksums:

```
Install-AlbertCode-<version>-windows-x64.cmd        Windows (x64; also runs on ARM)
Install-AlbertCode-<version>-macos-arm64.command    Mac with Apple silicon
Install-AlbertCode-<version>-macos-x86_64.command   Mac with Intel
Install-AlbertCode-<version>-linux-x86_64.sh        Linux, x86-64
Install-AlbertCode-<version>-linux-aarch64.sh       Linux, ARM
SHA256SUMS                                          "<sha256>  <file>" for each of the above
```

The bootstrap picks the one for the machine it runs on. A Mac with Apple silicon counts as arm64
even in a terminal running under Rosetta. An installer named without a processor
(`Install-AlbertCode-<version>.sh`) is used when there is none for this processor.

## Testing

```bash
sh installer/tests/test_install_sh.sh                            # macOS, Linux
pwsh -NoProfile -File installer/tests/test_install_ps1.ps1       # any system with PowerShell
shellcheck -s sh installer/install.sh
```

The tests build a fake release on disk and point the bootstrap at it with
`ALBERTCODE_DOWNLOAD_BASE`, so nothing is downloaded or installed. CI runs them on Linux, macOS and
Windows.

## Rules for changes

- **Ask before changing anything.** The bootstrap only downloads, checks and hands over. Anything
  that changes the machine goes through the installer's plan and question, or the uninstaller's.
- **Never run what failed its checksum**, and never offer a way to skip the check.
- **Stay portable.** `install.sh` is POSIX sh (it may run under dash), and `install.ps1` must work
  in Windows PowerShell 5.1 and must never call `exit`, because under `| iex` that closes the
  user's window.
- **Explain failures.** Say what went wrong and what to do next.
