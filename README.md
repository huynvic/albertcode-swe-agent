<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/logo/mark.svg">
  <img src="assets/logo/mark-light.svg" alt="AlbertCode" width="84" height="84">
</picture>

<h1>AlbertCode SWE Agent</h1>

<p><strong>The coding agent that proves its work.</strong><br>
It plans, changes, tests and reviews in an isolated copy of your repository,<br>
and touches your files only when you approve.</p>

<p>
<a href="https://github.com/huynvic/albertcode-swe-agent/releases/latest"><img src="https://img.shields.io/github/v/release/huynvic/albertcode-swe-agent?label=release&color=FF7A4D" alt="Latest release"></a>
<a href="docs/installation.md"><img src="https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-0D1117" alt="Windows, macOS and Linux"></a>
<a href="https://github.com/huynvic/albertcode-swe-agent/actions/workflows/checks.yml"><img src="https://github.com/huynvic/albertcode-swe-agent/actions/workflows/checks.yml/badge.svg" alt="Checks"></a>
<a href="https://github.com/huynvic/albertcode-swe-agent/stargazers"><img src="https://img.shields.io/github/stars/huynvic/albertcode-swe-agent?style=flat&color=FF7A4D" alt="GitHub stars"></a>
</p>

<p>
<a href="#installation">Install</a> ·
<a href="#quick-start">Quick start</a> ·
<a href="docs/getting-started.md">Docs</a> ·
<a href="https://github.com/huynvic/albertcode-swe-agent/releases">Releases</a> ·
<a href="https://github.com/huynvic/albertcode-swe-agent/discussions">Discussions</a>
</p>

<img src="assets/demo/albertcode-demo.gif" alt="A terminal session: a request is typed, AlbertCode analyses the repository, prepares a plan that is approved, implements the change in an isolated copy, runs the tests, verifies and reviews it, then reports it is ready for approval." width="820">

<sub>Illustrative walkthrough. The real interface shows more detail at each step.</sub>

</div>

---

## Installation

**macOS and Linux**

```bash
curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh
```

**Windows** (PowerShell)

```powershell
irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 | iex
```

The installer picks the build for your machine and verifies its SHA-256 checksum. It then shows
what it will do and asks before it changes anything. It installs everything AlbertCode needs,
including Python, for your user only. No pip, virtual environments or PATH editing.

<details>
<summary><strong>Other ways to install, update or remove</strong></summary>

<br>

**Download an installer.** Each [release](https://github.com/huynvic/albertcode-swe-agent/releases/latest)
has one per system, plus `SHA256SUMS`:

| System | File |
|---|---|
| Windows 10 and 11 (x64; also runs on ARM) | `Install-AlbertCode-<version>-windows-x64.cmd` |
| macOS, Apple silicon | `Install-AlbertCode-<version>-macos-arm64.zip` |
| macOS, Intel | `Install-AlbertCode-<version>-macos-x86_64.zip` |
| Linux (glibc), x86-64 | `Install-AlbertCode-<version>-linux-x86_64.sh` |

**VS Code extension.** Download `albertcode-<version>.vsix` from the same release, then choose
*Extensions → … → Install from VSIX*.

**Update.** Run the install command again.

**Uninstall.** Run the install command with `--uninstall`, which asks first and keeps your
settings:

```bash
curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh -s -- --uninstall
```

```powershell
$env:ALBERTCODE_INSTALL_ARGS = '--uninstall'; irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 | iex
```

The installers aren't code-signed yet. [Installation](docs/installation.md) covers SmartScreen,
Gatekeeper, manual checksum checks, proxies and other options.

</details>

## Quick start

```bash
cd your-project
albertcode
```

The first time, AlbertCode asks you to connect a model: paste an API key, or point it at a model
running on your machine. Then describe what you want:

```text
› The login endpoint returns 500 when the password is empty. Fix it and add a test.
```

AlbertCode reads the repository and proposes a plan. You approve the plan. It makes the change
in an isolated copy, runs your tests, reviews the result, and shows you the diff. You accept it,
and only then does the change reach your files.

[Getting started](docs/getting-started.md) walks through a first task in about five minutes.

## How it works

| | Step | What you see |
|:-:|---|---|
| 1 | **Plan** | The goal, the files it expects to touch, the test plan and the risk. Nothing is written yet. |
| 2 | **Approve** | You accept the plan, or reject it and rephrase. |
| 3 | **Build** | The change is made in an isolated copy of your repository, never in your working tree. |
| 4 | **Verify** | Your project's own tests and checks run, and the change is reviewed. |
| 5 | **Accept** | You read the diff and the results, then apply it, or discard it. |

If you edited a file the change also touches, acceptance is refused rather than overwriting your
work. Accepted changes are ordinary edits: commit them, or undo them, with Git.

## Features

- **Approval built in.** Two clear decision points, so nothing reaches your repository by surprise.
- **Changes are proven, not just written.** AlbertCode runs your own toolchain (pytest, npm
  scripts, `go test`, cargo, Maven, Gradle, `dotnet`) and shows what passed and what didn't.
- **Choose your pace.** *Governed* for changes you care about, *fast* for small ones, *direct* to
  work in your files with a prompt before each write, and *ask* to explore a codebase without
  changing anything.
- **Any model.** Connect a hosted provider or a local model, and switch at any time.
- **Three interfaces.** Terminal (`albertcode`), browser (`albertcode --ui`) and VS Code, all
  driving the same local service.
- **A record of every change.** Each task keeps its plan, test results, review and diff
  together, in a tamper-evident log you can export.
- **Extensible.** [MCP servers](docs/extending.md#mcp-servers), plus
  [custom commands and agents](docs/extending.md) written as Markdown files.
- **Private by default.** It runs on your machine, with no account and no telemetry.

## Models

| Provider | Connect with |
|---|---|
| OpenAI · Anthropic · Kimi | An API key |
| OpenRouter | An API key: many vendors' models through one account |
| Hugging Face | A token, for open-weight models |
| Any OpenAI-compatible service | Its address, and a key if it needs one |
| Your own machine | Ollama, LM Studio, vLLM or any OpenAI-compatible local server |

AlbertCode checks a key or address works before saving it. The model must support tool calling;
`/test` checks one in a single request. More in [Models](docs/models.md).

## Privacy and security

Your code goes only to the model provider you choose. With a local model, it never leaves your
machine. Saved keys are kept by your system's own protection (the macOS Keychain, Windows data
protection or your Linux keyring), and are never given to the commands AlbertCode runs. Only
AlbertCode itself can use the service it runs on your computer. There's no telemetry and no
account. See the [security model](docs/security.md) and [PRIVACY.md](PRIVACY.md). To report a
vulnerability, follow [SECURITY.md](SECURITY.md).

## Benchmarks

No results have been published yet. Each result will state its benchmark, model, task count,
method and cost, and will be labelled **self-reported** or **independently verified**. See
[how results are reported](benchmarks/README.md).

## Documentation

| | |
|---|---|
| [Getting started](docs/getting-started.md) | Install, connect a model, and complete a first task |
| [Installation](docs/installation.md) | Options, updating, uninstalling and requirements |
| [Using AlbertCode](docs/usage.md) | Modes, approvals, commands and scripting |
| [Models](docs/models.md) | Providers, local models, and what a model needs |
| [Extending](docs/extending.md) | Custom commands, custom agents and MCP servers |
| [Security model](docs/security.md) | How your keys, code and data are protected |
| [Troubleshooting](docs/troubleshooting.md) | Fixes for common problems |
| [FAQ](docs/faq.md) | Short answers |

## FAQ

<details>
<summary><strong>How is AlbertCode different from other coding agents?</strong></summary>

<br>

Many agents edit your working tree as they go, and leave you to work out whether the result is
right. AlbertCode builds the change in an isolated copy. It runs your own tests, reviews the
change, and brings you a diff with the evidence, and you decide whether it lands. When you want
speed instead, fast and direct modes skip the ceremony.

</details>

<details>
<summary><strong>Is AlbertCode open source?</strong></summary>

<br>

No. AlbertCode SWE Agent is a proprietary product. This repository is open: its documentation,
installer, examples and benchmark methodology welcome contributions. See
[the FAQ](docs/faq.md#is-albertcode-open-source).

</details>

<details>
<summary><strong>Does it cost anything?</strong></summary>

<br>

You use your own model provider account, or a free local model. AlbertCode doesn't charge for
model usage.

</details>

## Community

- **Questions and ideas:** [Discussions](https://github.com/huynvic/albertcode-swe-agent/discussions)
- **Bugs and feature requests:** [Issues](https://github.com/huynvic/albertcode-swe-agent/issues/new/choose)
- **What's coming:** the [roadmap](ROADMAP.md) and the [changelog](CHANGELOG.md)
- **Contributing:** docs, examples, the installer and integrations. See [CONTRIBUTING.md](CONTRIBUTING.md).

If AlbertCode saves you time, a ⭐ helps other developers find it.

## License

AlbertCode SWE Agent is proprietary software, and it isn't covered by the licences in this
repository. Code in this repository is [Apache-2.0](LICENSE), and its documentation is
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). See [LICENSING.md](LICENSING.md).
