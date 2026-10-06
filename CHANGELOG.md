# Changelog

Release notes for AlbertCode SWE Agent, newest first. Each release's installers and checksums are
on the [releases page](https://github.com/huynvic/albertcode-swe-agent/releases).

## 1.39.0 — 2026-10-06

- **Browser tests.** **Test** in the top bar checks your app the way people use it, with Playwright
  tests kept in your repository's `e2e/` folder. Albert writes them as a normal task (you approve
  the plan and the diff); one click installs the runner and runs them against your app. A failure
  shows its error, a screenshot and a trace, and **Fix with Albert** starts a task to fix it. An
  installed Chrome, Edge or Chromium is used; a browser is downloaded only if there is none, and
  only when you ask.
- **Preview, beside the chat.** **Preview** starts your app and shows it at desktop, tablet or phone
  width, says whether it is answering, and says plainly when something is wrong, with **Ask Albert
  to fix**.
- **A task board.** **Tasks** shows every task in five columns, Planned, Active, Blocked, Verifying
  and Completed, with what each one is waiting for.
- **A terminal inside the browser**, beside the chat or under it, with tabs, in your repository.
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
