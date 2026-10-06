# Changelog

Release notes for AlbertCode SWE Agent, newest first. Each release's installers and checksums are
on the [releases page](https://github.com/huynvic/albertcode-swe-agent/releases).

## 1.33.2 — 2026-10-06

- **Tasks start on Windows in projects with a `node_modules` folder.** Earlier versions failed
  every such task with "Internal Server Error"; projects on USB drives and some network shares
  could fail the same way on macOS and Linux.
- **`albertcode --ui` opens the browser page signed in again**, instead of a page asking you to run
  `albertcode --ui`.
- **`albertcode uninstall`** removes AlbertCode on Windows, macOS and Linux with nothing downloaded.
  `--all` also removes settings, saved keys and task history.

## 1.33.1 — 2026-10-05

AlbertCode's own logo and colour, everywhere.

- The AlbertCode logo is a sharp vector image in the browser interface, and VS Code's activity bar
  shows it instead of the old "A" icon.
- The browser, the terminal and VS Code all use the logo's signal orange, `#FF7A4D`.
- The terminal's `/help` no longer lists `/fast`: the modes are Governed, Direct and Ask.

## 1.33.0 — 2026-10-05

Security hardening for everything AlbertCode keeps on your computer. See the
[security model](docs/security.md).

- Only AlbertCode itself can use the service it runs on your computer. The terminal, VS Code and
  `albertcode --ui` sign in automatically.
- Saved keys and MCP sign-ins are kept by the macOS Keychain, Windows data protection or your
  Linux keyring, and are never passed on a command line.
- Your keys are never given to the commands AlbertCode runs, including your project's Git hooks,
  and are masked if they turn up in anything sent to the model.
- AlbertCode's folders and task database are readable only by you.

## 1.32.0 — 2026-10-05

The first public release.

- Installers for Windows (x64), macOS (Apple silicon and Intel) and Linux (x86-64), with
  `SHA256SUMS`. The one-line install command picks the right one for your machine and checks it.
- The VS Code extension, as `albertcode-1.32.0.vsix`.
- With no model connected, the first run opens the connect step straight away.

## Unreleased

- This repository: documentation, the bootstrap installer, examples and benchmark methodology.
  Its code is Apache-2.0 and its documentation CC BY 4.0 (see LICENSING.md).
