# Changelog

Release notes for AlbertCode SWE Agent, newest first. Each release's installers and checksums are
on the [releases page](https://github.com/huynvic/albertcode-swe-agent/releases).

## 1.37.0 — 2026-10-06

- **A terminal inside the browser.** **Terminal** in the top bar (or Ctrl+`) opens a real shell in
  the open repository: zsh or bash on macOS and Linux, PowerShell on Windows. It sits beside the
  chat like Files, or docked under it; one button moves it, and AlbertCode remembers the choice.
  Tabs, colours, clickable links, copy and paste; shells keep running when it is hidden, moved or
  the page reloads. Off until you turn it on; only your own AlbertCode page can connect; opening
  and closing a shell are in the evidence ledger.
- **Governed changes.** AlbertCode plans a change, you approve the plan, it builds the change in an
  isolated copy of your repository, runs your own tests, reviews the result, and shows you the diff.
  Your files change only when you accept it.
- **Three interfaces.** The terminal (`albertcode`), the browser (`albertcode --ui`) and VS Code,
  all driving the same local service. Three modes: Governed, Direct and Ask.
- **A Files panel in the browser**: new file and folder, rename, duplicate, copy, cut and paste,
  copy a path, and move to the Trash, inside the open repository only.
- **Any model**: hosted providers, any compatible API service, or a model on your own machine.
- **Private by default.** Keys are kept by your system's own protection (the macOS Keychain,
  Windows data protection or your Linux keyring); only AlbertCode itself can use its local service;
  no telemetry and no account. See the [security model](docs/security.md).
- **Installers for Windows, macOS and Linux**, each checked against `SHA256SUMS`, and
  `albertcode uninstall` to remove AlbertCode with nothing downloaded.
