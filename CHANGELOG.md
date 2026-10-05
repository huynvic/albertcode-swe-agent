# Changelog

Release notes for AlbertCode SWE Agent, newest first. Each release's installers and checksums are
on the [releases page](https://github.com/huynvic/albertcode-swe-agent/releases).

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
