# Security model

AlbertCode runs on your computer, with your keys and your code. This page explains what it
protects, and how. It also says what it can't protect against.

This describes the current version of AlbertCode. Run `albertcode --version` to check, and the
[install command](installation.md) to update.

## In short

- Only AlbertCode itself can use the service it runs on your computer.
- Your keys are kept by your operating system's own protection, and go only to the provider they
  belong to.
- Nothing reaches your files until you approve it.
- AlbertCode keeps its data in folders only you can read.
- There's no telemetry and no account.

## Only AlbertCode can use its service

AlbertCode runs a small service on your computer at `127.0.0.1`. Every program on a computer can
reach that address, so the service checks who is asking.

Each installation has its own access token: a long random value in a file only you can read. The
terminal and the VS Code extension send it automatically. `albertcode --ui` signs your browser in,
and the page then keeps the token in a cookie that scripts can't read and other websites can't
send. Other programs, and other people with an account on the same computer, are refused.

A new version gets a new token. If a browser page asks you to open AlbertCode from your terminal,
run `albertcode --ui`.

## Your keys

| System | Where saved keys are kept |
|---|---|
| macOS | Your login Keychain |
| Windows | Encrypted with Windows data protection, for your user account only |
| Linux desktop | Your desktop keyring (GNOME Keyring or KWallet) |
| Linux without a keyring (servers, containers, SSH sessions) | A file only your user can read |

This applies to model provider keys and to sign-ins for MCP servers.

- **A key goes only to the provider it belongs to.** AlbertCode never shows a saved key again:
  the interface shows its last four characters, so you can tell which key is in place.
- **A key is never passed on a command line.** Other programs can list command lines while they
  run.
- **The commands AlbertCode runs never get your keys.** That covers your tests, your build, your
  project's Git hooks, and MCP servers. Each gets only what it needs to run. To give an MCP
  server a key, reference it by name in that server's settings.
- **Your keys aren't sent to the model.** If a saved key turns up in a file the agent reads, or
  in a command's output, it's masked before anything goes to the model provider.
- **`/disconnect`** removes a saved key, and `/disconnect all` removes all of them. Installing a
  new version also clears saved model keys, so connect again with `/connect`. MCP sign-ins are
  kept.

## Your code

- **Nothing reaches your files without your approval.** You approve the plan before work starts.
  The change is then made in an isolated copy of your repository, and you approve the result
  before it's applied.
- **Your newer edits are never overwritten.** If you changed a file the task also changed,
  applying the change is refused.
- **Code goes only to the model provider you choose.** With a local model, it stays on your
  computer. See [PRIVACY.md](../PRIVACY.md) for everything AlbertCode sends, and where.
- **Direct mode** works in your files themselves, and you choose whether it asks before each
  write. Use governed mode when you want the isolated copy and both approvals.

## Files on your computer

AlbertCode's data folder holds your settings, your task history (plans, diffs, test results and
reviews), and the isolated copies tasks work in. On macOS and Linux the folder is readable only by
you, and so is the task database inside it. On Windows it is in your own profile, which other
standard users can't read.

## The terminal in the browser

The browser can show a real shell, beside the chat or under it. Because what you type there runs on your
computer as you, outside the limits AlbertCode puts on the agent's commands:

- It is **off until you turn it on**, and the panel says what it allows before you can.
  Turning it off closes every shell it opened.
- **Only your own AlbertCode page can connect.** Each shell has its own key, held by the page, and
  the connection must also come from AlbertCode's own page and carry its sign-in. The key never
  appears in an address.
- A **shared AlbertCode server never offers it**; it exists only when AlbertCode runs for one person
  on their own computer.
- **No model key is in the shell's environment.**
- Turning it on or off and opening or closing a shell are **recorded in the evidence ledger**.
  What you type is not.

## Preview and browser tests

- **Your click starts them.** The preview, installing the test runner, downloading a browser and
  running tests each happen only when you ask, in the open repository, and on your own computer
  only. Each is recorded in the evidence ledger.
- **Fixed programs.** Only the test runner, its browser install and your package manager's install
  run, with no shell in between. A single test file can be run only if it is one of the
  repository's own.
- **No secrets in a test run.** Settings that hold keys are removed from its environment, and its
  output is checked for secrets before it is shown.
- **Tests are written like any change**, as a task with a plan and a diff you approve.

## Requirements

- The list is saved in the open repository, at `.albertcode/requirements.json`, only when you click
  **Save**, and never through a link. Saving is recorded in the evidence ledger.
- A specification is sent only to the model you chose, like any chat message; without one, it is
  split on your computer.
- Its buttons only put a request in the chat. Nothing is built until you send it and approve the
  plan and the diff.

## Architecture

- It only reads, in the open repository, and runs nothing. It never follows a link and skips
  dependencies and build output.
- Files that may hold a secret (your `.env`, keys, a secrets folder) are never read.
  `.env.example` and similar files are read for variable names only, never values.

## The installer

The install command downloads `SHA256SUMS` from this repository's release, and checks the
installer against it before running it. AlbertCode is installed for your user only. The
installers aren't code-signed yet, so Windows and macOS may warn you the
first time. [Installation](installation.md#unsigned-installers) explains how to check one
yourself.

## What this relies on

These protections assume the following. If one doesn't hold for you, the protections that depend
on it are weaker.

- **Your computer and your user account are yours, and not compromised.** AlbertCode protects
  you from other users of the computer, and from other programs reaching its service. It can't
  protect you from malware already running as you.
- **One person uses each user account.** Anyone who can sign in as you can use AlbertCode as you.
- **The computer's administrators are trusted.** An administrator (or `root`) can read every
  file on the computer, including AlbertCode's.
- **Your model provider, and any MCP servers or search service you connect, are trusted** with
  what they receive. AlbertCode sends them what a task needs; it can't control what they keep.
- **You read the plan and the diff before you approve them.** Approval is the main safeguard
  against a wrong or harmful change.
- **The service stays on `127.0.0.1`**, as installed. Making it reachable from a network is a
  server deployment, which needs its own sign-in (see below).
- **GitHub and pypi.org serve what the publishers uploaded.** The installer comes from this
  repository's releases, and AlbertCode's open-source dependencies from pypi.org.

## Limitations

What AlbertCode does not do, or does only partly:

- **Other programs running as you can read your keys.** The macOS Keychain, Windows data
  protection and the Linux keyring keep keys from other users. They don't keep them from other
  programs running under your own account, and neither do the access-token file and the
  owner-only files.
- **Without a keyring, keys aren't encrypted.** On Linux servers, containers and SSH sessions,
  keys are in a file only your user can read, not an encrypted one. Other command-line tools do
  the same.
- **Task history isn't encrypted.** Plans, diffs and conversations are protected by folder
  permissions, not encryption. Turn on disk encryption (FileVault, BitLocker or LUKS) to protect
  them if the computer is lost or stolen.
- **Masking only covers your saved keys, by exact value.** In governed mode, common secret files
  (`.env` files, private keys, credential files, `secrets/` and `.ssh/` folders) are left out of
  the isolated copy, so the agent never sees them. Any other secret in your code, such as a
  password written into a source file, can be read and sent to the model like the rest of the
  code. A saved key that has been encoded or split isn't recognised.
- **Your project's commands run with your permissions.** Your tests and build can reach the
  network, and files outside the repository. The isolated copy keeps changes away from your
  files until you approve them; it isn't a sandbox. Only use AlbertCode with repositories whose
  commands you would run yourself.
- **Instructions hidden in content the agent reads**, such as a file, a web page, an issue or an
  MCP server's answer, may try to steer it. Your two approvals are the safeguard.
- **Your model provider's handling of your data** is covered by the provider's terms. Use a
  local model if no code should leave your computer.
- **The installers aren't code-signed yet.** The checksum check catches a damaged or swapped
  download. It can't catch a release that was published from a compromised GitHub account.
  AlbertCode's dependencies are pinned to exact versions, not to checksums.
- **The browser sign-in lasts a year** in the browser profile you opened it in. Anyone using that
  browser profile is signed in. A new version of AlbertCode signs every browser out.
- **Uninstalling keeps your settings and saved keys.** Run `/disconnect all` first, or delete
  AlbertCode's data folder afterwards, to remove them. Deleted files aren't securely wiped.

### On a server

When an organisation runs AlbertCode as a shared service, some protections work differently.

- **The access token is not used.** Each person signs in instead, with their own API key or the
  organisation's single sign-on, as whoever runs the server configures it.
- **The server's model keys come from the server's own configuration**, usually not a keychain.
  Protecting that configuration is up to whoever runs the server.
- **Keys still stay out of the commands AlbertCode runs**, and are masked from anything sent to
  the model.
- **A PostgreSQL database is protected by its own access controls**, not by AlbertCode's folder
  permissions.

## Reporting a problem

If you find a security problem, please report it privately, as [SECURITY.md](../SECURITY.md)
describes. Don't open a public issue.
