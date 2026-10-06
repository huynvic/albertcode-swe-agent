<div align="center">

<img src="assets/logo/albertcode-logo.png" alt="AlbertCode" width="96" height="96">

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

**macOS and Linux** (Terminal)

```bash
curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh
```

**Windows** (PowerShell)

```powershell
irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 | iex
```

The installer picks the build for your machine and verifies its SHA-256 checksum. It then shows
what it will do and asks `Proceed? [Y/N]` before it changes anything. It installs everything
AlbertCode needs, including Python, for your user only. No pip, virtual environments or PATH
editing. It takes a minute or two.

When it finishes, **open a new terminal** and check it:

```bash
albertcode --version     # AlbertCode SWE Agent 1.33.2
albertcode doctor        # which build tools AlbertCode can find
```

### Requirements

| | |
|---|---|
| **Windows** | Windows 10 or 11, x64 (the x64 build also runs on ARM PCs). PowerShell 5.1 or 7 |
| **macOS** | A current macOS, on Apple silicon or Intel |
| **Linux** | x86-64 with glibc: Ubuntu 20.04+, Debian 10+, Fedora, RHEL 8+, openSUSE, Arch. Not Alpine or other musl systems, and not ARM yet |
| **Disk** | About 1 GB free |
| **Network** | pypi.org and github.com while installing; your model provider while working |
| **Git** | Recommended. The installer offers to install it if it's missing |

You don't need Python: the installer uses your Python 3.12 if you have it, and otherwise downloads
one for AlbertCode alone.

<details>
<summary><strong>Step by step on macOS</strong></summary>

<br>

1. Open **Terminal** (Applications → Utilities, or press ⌘ Space and type *Terminal*).
2. Paste the macOS command above and press Return.
3. Read the plan, then type `Y`.
4. Close Terminal and open a new window, then run `albertcode --version`.

**Prefer a download?** From the [latest release](https://github.com/huynvic/albertcode-swe-agent/releases/latest),
take the `.zip` for your Mac: `macos-arm64` for Apple silicon (M1 and later), `macos-x86_64` for
Intel. Not sure which you have? Open the Apple menu → *About This Mac*. Open the zip, then double-click
the installer inside it.

The installers aren't code-signed yet, so the first time macOS says it can't verify the installer.
Choose *Done*, open **System Settings → Privacy & Security**, click **Open Anyway**, then open the
installer again. The one-line command above avoids this.

</details>

<details>
<summary><strong>Step by step on Windows</strong></summary>

<br>

1. Open **PowerShell**: press the Windows key, type *PowerShell*, and press Enter. You don't
   need "Run as administrator".
2. Paste the Windows command above and press Enter.
3. Read the plan, then type `Y`.
4. Close PowerShell and open a new window, then run `albertcode --version`.

**Prefer a download?** From the [latest release](https://github.com/huynvic/albertcode-swe-agent/releases/latest),
take `Install-AlbertCode-<version>-windows-x64.cmd` and double-click it. The installers aren't
code-signed yet, so SmartScreen may say it protected your PC. Choose *More info* → *Run anyway*.

If your organisation blocks PowerShell scripts, use the downloaded `.cmd` installer instead.

</details>

<details>
<summary><strong>Step by step on Linux</strong></summary>

<br>

1. Open a terminal. Make sure `curl` is installed (`sudo apt install curl` on Ubuntu and Debian).
2. Paste the Linux command above and press Enter. Run it as yourself, not with `sudo`.
3. Read the plan, then type `Y`. It asks for your password only if it needs to install Git.
4. Open a new terminal, then run `albertcode --version`.

**Prefer a download?** From the [latest release](https://github.com/huynvic/albertcode-swe-agent/releases/latest),
take `Install-AlbertCode-<version>-linux-x86_64.sh` and run `bash Install-AlbertCode-<version>-linux-x86_64.sh`.

</details>

<details>
<summary><strong>Update, uninstall, VS Code extension and other options</strong></summary>

<br>

**Update.** Run the install command again. It shows what will change, then replaces the old
version. Saved model keys are cleared the first time a new version starts, so reconnect with
`/connect`.

macOS and Linux (Terminal):

```bash
curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh
```

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 | iex
```

**Uninstall.** It lists what it will remove and asks first. Your settings are kept.

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

**VS Code extension.** Download `albertcode-<version>.vsix` from the
[latest release](https://github.com/huynvic/albertcode-swe-agent/releases/latest), then in VS Code
choose *Extensions → … → Install from VSIX*. Install AlbertCode itself first: the extension uses it.

**Other options:** `--check` only shows the plan, `--yes` installs without asking (for scripts and
CI), and `--version X.Y.Z` installs a specific release. On Windows, put options in
`ALBERTCODE_INSTALL_ARGS` as above. Manual checksum checks, proxies and more are in
[Installation](docs/installation.md).

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

## Using AlbertCode

**Three interfaces, one agent.** All three use the same local service, so a task started in one can
be followed in another.

| Interface | Start it | Good for |
|---|---|---|
| Terminal | `albertcode` in your project folder | Working where you already are |
| Browser | `albertcode --ui` | Reading plans and diffs side by side; several sessions at once |
| VS Code | The AlbertCode panel, or right-click a folder → *Open Here* | Staying in your editor |

**Three modes.** Switch with `/mode`, or use one for a single request with `/plan` or `/do`.

| Mode | What happens | Use it for |
|---|---|---|
| **Governed** (default) | You approve a plan; it works in an isolated copy, runs your tests and reviews the result; you approve the diff | Changes you care about |
| **Direct** | It works in your files, asking before each write, or applying writes as they come with `auto`. Needs Git | Quick changes you're watching |
| **Ask** | It answers questions and changes nothing | Understanding a codebase |

**Everyday commands** (type `/help` for all of them):

| Command | |
|---|---|
| `/connect` | Connect a model provider: its key, or the address of a local model |
| `/model` | Choose a model |
| `/test` | Check that a model can drive AlbertCode |
| `/plan <request>` | Start a governed change |
| `/attach <paths>` | Give it files or screenshots |
| `/tasks` | Recent tasks |
| `/status` | The repository and model in use |
| `/exit` | Leave. The service keeps running; `albertcode stop` stops it |

Every step is also a subcommand (`albertcode create`, `approve`, `diff`, `accept`), so AlbertCode
fits scripts and CI. See [Using AlbertCode](docs/usage.md).

## Troubleshooting

<details>
<summary><strong>Installing</strong></summary>

<br>

| Problem | Fix |
|---|---|
| `albertcode: command not found` right after installing | Open a new terminal. The installer added the command to your PATH, and only new terminals see it |
| **macOS:** "could not be executed because you do not have appropriate access privileges" | The browser saved the installer without permission to run. Download the `.zip` for your Mac instead, or run `bash ~/Downloads/Install-AlbertCode-<version>-macos-arm64.command` in Terminal (`x86_64` on Intel) |
| **macOS:** "Apple could not verify…" or "unidentified developer" | Open **System Settings → Privacy & Security**, click **Open Anyway**, and open the installer again. Or use the one-line command |
| **Windows:** "Windows protected your PC" | Choose *More info* → *Run anyway* |
| **Windows:** PowerShell refuses to run the command | Your organisation may block scripts. Download the `.cmd` installer from the release and double-click it instead |
| **Linux:** the installer refuses to run under `sudo` | Run it as yourself. It installs for your user, and asks for `sudo` only if Git is missing |
| **Linux:** "the release has no installer for Linux on … processors" | Only x86-64 is supported for now, not ARM |
| **Linux:** the install fails on Alpine or another musl-based system | Not supported: AlbertCode needs a glibc-based distribution such as Ubuntu, Debian or Fedora |
| pypi.org can't be reached | Check your connection. Behind a proxy, set `HTTPS_PROXY` and run the command again |
| `invalid peer certificate` or `UnknownIssuer` | Your network inspects encrypted traffic. Current installers retry with your computer's certificates; if that fails, set `UV_NATIVE_TLS=1` and run again |
| "the package inside it is damaged" | The download was cut short or altered. Download it again |

Every installer run writes a log: `~/.local/share/albertcode-installer/install.log` on macOS and
Linux, `%LOCALAPPDATA%\AlbertCode\install.log` on Windows.

</details>

<details>
<summary><strong>Running</strong></summary>

<br>

| Problem | Fix |
|---|---|
| "No model is connected" | Run `/connect`, or choose **Connect a provider** in the browser or VS Code |
| After updating, your model is no longer connected | Saved keys are cleared when a new version first starts. Run `/connect` again |
| A model connects but tasks stall or fail early | The model may not handle tool calling well. Run `/test`, and see [Models](docs/models.md#what-a-model-needs) |
| Tests don't run, or use the wrong tool | Run `albertcode doctor` to see which build tools AlbertCode finds, then install or add the missing one to your PATH |
| The browser page says to open AlbertCode from your terminal | Run `albertcode --ui`. It signs your browser in |
| VS Code can't reach AlbertCode | Run `albertcode` once in a terminal to start the service, then reload the VS Code window |
| Accepting a change is refused | You edited a file the change also touches. Look at your edits, then run the task again |
| Everything seems stuck | Run `albertcode stop`, then `albertcode` again |

</details>

Still stuck? [Open an issue](https://github.com/huynvic/albertcode-swe-agent/issues/new/choose) with
what you ran, what you expected and what happened, plus `albertcode --version` and your operating
system. Never include keys, tokens or private code. More fixes are in
[Troubleshooting](docs/troubleshooting.md).

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
- **Choose your pace.** *Governed* for changes you care about, *direct* to work in your files with
  a prompt before each write (or none, with *auto*), and *ask* to explore a codebase without
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
| Major hosted model providers, and Kimi | An API key |
| OpenRouter | An API key: many vendors' models through one account |
| Hugging Face | A token, for open-weight models |
| Any compatible API service | Its address, and a key if it needs one |
| Your own machine | Ollama, LM Studio, vLLM or another local model server |

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

| Benchmark | Model | Resolved | Status |
|---|---|---|---|
| [SWE-bench Pro HARD-51](benchmarks/results/swe-bench-pro-hard51-2026-09-frontier-model/REPORT.md) | A frontier hosted model | **39 of 51 (76%)** | Self-reported |

SWE-bench Pro is Scale AI's benchmark of real software-engineering work: issues and features in
professional open-source projects, judged by each project's own hidden tests. HARD-51 is its
hardest part, the tasks that at least two of five frontier model families failed. AlbertCode had
one attempt per task, up to 50 minutes each, with no human help. On the 22 tasks held out from all
of its development, it resolved 14. We ran and graded this ourselves; it hasn't been independently
verified. The [report](benchmarks/results/swe-bench-pro-hard51-2026-09-frontier-model/REPORT.md) gives the method, every task's outcome and the limitations.

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
speed instead, direct mode skips the ceremony.

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
