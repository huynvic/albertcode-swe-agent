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
AlbertCode itself collects no telemetry and has no account to sign in to. With a local model, your
code never leaves your machine. See [PRIVACY.md](../PRIVACY.md).

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

AlbertCode doesn't charge for model usage: you use your own provider account, or a local model.
Terms for AlbertCode itself will be published with the first public release.

## Where are the benchmark results?

None have been published yet. The [benchmarks](../benchmarks/README.md) page explains how they will
be reported, and that self-reported and independently verified results will be kept apart.

## How do I report a security problem?

Privately, as described in [SECURITY.md](../SECURITY.md). Please don't open a public issue.

## Can I contribute?

Yes, to documentation, examples, the installer, integrations and benchmark reproduction. See
[CONTRIBUTING.md](../CONTRIBUTING.md).
