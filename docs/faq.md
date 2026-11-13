# FAQ

## Is AlbertCode open source?

No. AlbertCode SWE Agent is a proprietary product. This repository is its public home, and these
parts of it are open to contributions:

| In this repository | Not in this repository |
|---|---|
| Documentation and tutorials | The AlbertCode engine: planning, verification, review |
| The bootstrap installer | Model prompts and orchestration |
| Example custom commands and agents | Internal services and APIs |
| Benchmark methodology and published results | Unpublished evaluations |
| Issues, discussions, roadmap, changelog | |

## Does it send my code anywhere?

Only to the model provider you choose, because the model needs to read the code to work on it.
AlbertCode has no account to sign in to, and never sends your code to us. With a local model, your
code never leaves your machine. See [PRIVACY.md](../PRIVACY.md).

## Does AlbertCode collect usage data?

From version 1.56.0, it sends an anonymous usage count: once when you first run a new version, and
at most once a day when you use it. A count holds only the version, your system, your computer's
chip and the interface you used, with no ID, and nothing about you or your code. The counts are kept
private and never published, shared or sold. To turn counting off, run `albertcode telemetry off`,
or set `ALBERTCODE_TELEMETRY=off` or `DO_NOT_TRACK=1`. See
[Anonymous usage counts](../PRIVACY.md#anonymous-usage-counts).

## Which models can I use?

Major hosted model providers, Kimi, Hugging Face, OpenRouter, any compatible API service, or a local model
through Ollama, LM Studio or vLLM. The model must support tool calling. See [Models](models.md).

## Can it change my files without asking?

Not in the default governed mode: you approve the plan, then the result. Direct mode asks before
each write, unless you set it to *auto*. You choose that explicitly.

## What happens if I edit a file while it's working?

In governed mode it works in an isolated copy, so your edits are safe. If you edit a file the change
also touches, acceptance is refused rather than overwriting your edit.

## Does it work offline?

With a local model, yes, once installed. Installing needs the network, and so do hosted models.

## What does it cost?

Nothing. AlbertCode is free to install and use, including at work, under its
[End User Licence Agreement](https://github.com/huynvic/albertcode-swe-agent/blob/main/EULA.md). It doesn't charge for model usage: you use your own provider
account, under that provider's terms, or a local model.

## Who is responsible for the code it writes?

You are. AI output can be wrong, incomplete or insecure. AlbertCode's plan, isolated copy, checks
and reviews reduce that risk, but they don't remove it, so review and test every change before you
accept it, and before you deploy it. The code AlbertCode writes for you is yours. See the
[End User Licence Agreement](https://github.com/huynvic/albertcode-swe-agent/blob/main/EULA.md), sections 3 and 4.

## Where are the benchmark results?

None have been published yet. The [benchmarks](../benchmarks/README.md) page explains how they will
be reported, and that self-reported and independently verified results will be kept apart.

## How do I report a security problem?

Privately, as described in [SECURITY.md](../SECURITY.md). Please don't open a public issue.

## Can I contribute?

Yes, to documentation, examples, the installer, integrations and benchmark reproduction. See
[CONTRIBUTING.md](../CONTRIBUTING.md).
