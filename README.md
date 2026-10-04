<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/logo/mark.svg">
  <img src="assets/logo/mark-light.svg" alt="AlbertCode" width="80" height="80">
</picture>

# AlbertCode SWE Agent

**A coding agent that plans, changes, tests and reviews, and touches your files only when you approve.**

[![Latest release](https://img.shields.io/github/v/release/huynvic/albertcode-swe-agent?label=release&color=3DDC97)](https://github.com/huynvic/albertcode-swe-agent/releases)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-0D1117)](docs/installation.md)
[![Checks](https://github.com/huynvic/albertcode-swe-agent/actions/workflows/checks.yml/badge.svg)](https://github.com/huynvic/albertcode-swe-agent/actions/workflows/checks.yml)
[![GitHub stars](https://img.shields.io/github/stars/huynvic/albertcode-swe-agent?style=flat&color=3DDC97)](https://github.com/huynvic/albertcode-swe-agent/stargazers)

<img src="assets/demo/albertcode-demo.gif" alt="A terminal session: a request is typed, AlbertCode analyses the repository, prepares a plan that is approved, implements the change in an isolated copy, runs the tests, verifies and reviews it, then reports it is ready for approval." width="820">

<sub>Illustrative walkthrough. The real interface shows more detail at each step.</sub>

</div>

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh
```

On Windows, in PowerShell:

```powershell
irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 | iex
```

The installer sets up everything AlbertCode needs, including Python, and asks before it changes
anything.

## Use

```bash
cd your-project
albertcode
```

```text
› The login endpoint returns 500 when the password is empty. Fix it and add a test.
```

The first time, type `/connect` to add a model: paste an API key, or point it at a local model.
Then you review the plan, AlbertCode makes the change and runs your tests, and you approve the
diff. [Getting started](docs/getting-started.md) walks through it.

## What you get

- **You approve twice.** First the plan, then the finished diff. Until then your files are
  untouched.
- **Changes are tested.** It runs your project's own tests (pytest, npm, `go test`, cargo, Maven,
  Gradle, `dotnet`) and shows you what passed.
- **Any model.** OpenAI, Anthropic, Kimi, OpenRouter, Hugging Face, or a local model through
  Ollama, LM Studio or vLLM.
- **Private by default.** It runs on your machine, with no account and no telemetry.
- **Terminal, browser or VS Code.** Run `albertcode`, `albertcode --ui`, or open the VS Code
  extension.

## Benchmarks

No results have been published yet. Each result will state its benchmark, model, task count and
cost, and will be labelled **self-reported** or **independently verified**.
[How we report results](benchmarks/README.md).

## Documentation

[Getting started](docs/getting-started.md) · [Installation](docs/installation.md) ·
[Using AlbertCode](docs/usage.md) · [Models](docs/models.md) · [Extending](docs/extending.md) ·
[Troubleshooting](docs/troubleshooting.md) · [FAQ](docs/faq.md)

**Need help?** [Open an issue](https://github.com/huynvic/albertcode-swe-agent/issues/new/choose) or
ask in [Discussions](https://github.com/huynvic/albertcode-swe-agent/discussions).
**Security issue?** See [SECURITY.md](SECURITY.md).

If AlbertCode saves you time, a ⭐ helps other developers find it.

<sub>AlbertCode SWE Agent is proprietary software. This repository holds its documentation, installer,
examples and benchmark reports. Their code is Apache-2.0 and their documentation CC BY 4.0. The
product itself is not covered ([licensing](LICENSING.md)).</sub>
