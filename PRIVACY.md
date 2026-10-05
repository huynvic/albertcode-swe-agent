# Privacy

AlbertCode SWE Agent runs on your machine. **It collects no telemetry, no analytics and no usage
data, and it has no account to sign in to.** Nothing about you or your code is sent to AlbertCode.

## Where your data goes

Data leaves your machine only where a feature you use needs it:

| What | Sent to | When |
|---|---|---|
| The parts of your repository a task needs, your requests, and attached files | The model provider you connected | Whenever the model works on a task or a chat. With a local model, this stays on your machine. |
| Search queries | DuckDuckGo, or a search service you configured with your own key | When a task searches the web |
| Requests for documentation pages | The documentation site | When a task reads documentation |
| Whatever an MCP server's tools are given | That MCP server | When a task uses one of its tools |
| A task's evidence summary | GitHub | Only if you ask AlbertCode to post it to a pull request, with your token |

Each provider and service handles what it receives under its own terms. Read your model provider's
data-use policy before sending it private code. If you want no code to leave your machine, use a
local model.

## What is kept on your machine

- **Settings**, in AlbertCode's settings folder. The provider keys and MCP sign-ins you saved are
  kept by your system's own protection: the macOS Keychain, Windows data protection, or your Linux
  desktop keyring. Without a keyring, they go in a file only your user can read. Keys are sent
  only to the provider they belong to. `/disconnect all` removes every saved key. See
  [Security model](docs/security.md).
- **Task history**: plans, diffs, test results, reviews and the evidence log, so you can review
  past work. `/tasks clear` deletes it.
- **Task workspaces**: the isolated copies of your repository that tasks work in. `/cleanup`
  shows their size and clears them.

| System | Settings folder |
|---|---|
| Windows | `%LOCALAPPDATA%\AlbertCode SWE Agent` |
| macOS | `~/Library/Application Support/AlbertCode SWE Agent` |
| Linux | `~/.local/share/AlbertCode SWE Agent` |

Uninstalling leaves this folder in place. Delete it to remove everything AlbertCode kept.

## The installer

The installer downloads from:

- this repository's releases;
- the official uv release on GitHub, pinned and checked against its SHA-256;
- Python's package index, pypi.org, for AlbertCode's dependencies;
- if needed, a Python build, Git (through winget, Homebrew or your Linux package manager), and a
  browser for the browser tools.

It sends nothing about your machine anywhere.

## Changes

Any change to what AlbertCode sends, or where it sends it, will be listed in this file and in the
[changelog](CHANGELOG.md) before it ships.
