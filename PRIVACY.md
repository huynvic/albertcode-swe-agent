# Privacy

Updated 13 November 2026

AlbertCode SWE Agent runs on your machine, with no account to sign in to. **Your code, your
prompts and your files are never sent to us.** From version 1.56.0, AlbertCode sends an anonymous
usage count, so we know how many people install and use it. A count has no ID and nothing about you
or your code, we keep it private, and you can turn counting off. See
[Anonymous usage counts](#anonymous-usage-counts).

This notice covers the AlbertCode apps: the installers, the `albertcode` command and service, the
terminal and browser interfaces, AlbertCode for editors and the VS Code extension. The website
www.albertcode.dev has its own section of the [privacy page](https://www.albertcode.dev/privacy),
which also shows this notice. Your use of AlbertCode is governed by its
[End User Licence Agreement](EULA.md), and the [Disclaimer](DISCLAIMER.md) explains what AI output,
and AlbertCode's information, can and cannot promise.

## Where your data goes

Apart from the anonymous usage count below, data leaves your machine only where a feature you use
needs it:

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

## Anonymous usage counts

From version 1.56.0, AlbertCode sends a small anonymous count to our website, www.albertcode.dev:

- once, the first time you run a new version (an *install* count), and
- at most once a day, on a day you use it (an *active* count).

A count holds only these five things:

| What | Example |
|---|---|
| What happened | `install` or `active` |
| AlbertCode's version | `1.56.0` |
| Your system | `linux`, `macos` or `windows` |
| Your computer's chip | `x86_64` or `arm64` |
| Where you used AlbertCode | `terminal`, `classic`, `browser`, `editor`, `setup` or `service` |

It holds no ID, no account, no name for you or your computer, no file or folder names, no code, no
prompts, no model or provider, and no keys. Counts can't be linked to each other or to you.

**Where it goes.** The website receives the count and keeps it, without your IP address, in a
private repository on GitHub that only AlbertCode's developer can read. The website is hosted by
Vercel, and GitHub keeps the repository, both in the United States. Like any web host, Vercel logs
each request, including the IP address it came from, and keeps those logs for a short time under
its own policy.

**What it is for.** Only to know how many people install and use AlbertCode, which versions and
systems to support, and how that changes over time. The counts themselves are never published,
shared or sold, and never combined with other data to identify anyone. We may mention overall
totals, such as how many computers used AlbertCode in a month.

**Turning it off.** Any one of these stops every count:

- run `albertcode telemetry off` (`albertcode telemetry on` turns it back on, and
  `albertcode telemetry status` shows which it is). Your choice is kept when you update AlbertCode;
- set the environment variable `ALBERTCODE_TELEMETRY=off`;
- set the environment variable `DO_NOT_TRACK=1`.

AlbertCode never sends counts from CI (where the `CI` environment variable is set). The installer
tells you about counting before it installs AlbertCode, and AlbertCode tells you again the first
time it starts. If a count can't be sent, for example offline or behind a firewall, it is dropped:
nothing is retried, and AlbertCode works the same. Versions before 1.56.0 send no counts.

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

The installer itself sends nothing about your machine anywhere.

## Changes

Any change to what AlbertCode sends, or where it sends it, will be listed in this file and in the
[changelog](CHANGELOG.md) before it ships.

## Questions

AlbertCode holds nothing about you. What it keeps stays on your machine, where you can remove it as
described above, and the usage counts carry nothing that could tell us which counts are yours, so
we can't find, correct or delete them for one person: turn counting off to stop sending them. For
anything else,
contact Huy Nguyen through the GitHub account [huynvic](https://github.com/huynvic), for example as an
issue in [albertcode-swe-agent](https://github.com/huynvic/albertcode-swe-agent/issues). Please do
not post personal details, keys or private code in a public issue.
