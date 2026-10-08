# Models

AlbertCode handles the engineering workflow: the plan, the isolated copy, the tests, the reviews and
the approvals. The model you choose does the reasoning. You can change models at any time, even
between two tasks in the same session.

## Supported providers

| Provider | What you need |
|---|---|
| Major hosted model providers | An API key. `/connect` lists every provider AlbertCode supports |
| Kimi (Moonshot) | An API key |
| Hugging Face | A token. Open-weight models run through Hugging Face's inference router |
| OpenRouter | An API key. Gives access to many vendors' models through one account |
| Any compatible API service | Its address and, if it needs one, a key |
| A model on your machine | Ollama, LM Studio, vLLM or another local model server |

## Connect a provider

| Interface | How |
|---|---|
| Terminal | `/connect`, or `/connect <provider>` |
| Browser | **Connect a provider** in the model menu, `/connect`, or the command palette |
| VS Code | **Connect a Provider**, or `/connect` |

1. Pick a provider.
2. Paste its key, or give the address of your local model server.
3. AlbertCode checks the key or address works **before** saving it, and shows the provider as
   connected only once that check has passed.
4. Choose a model from the list that opens.

The first time you run AlbertCode with nothing connected, the connect step opens by itself.

### Local models

Start your model server, then connect **a model on your machine** with its address:

| Server | Usual address |
|---|---|
| Ollama | `http://localhost:11434/v1` |
| LM Studio | `http://localhost:1234/v1` |
| vLLM | `http://localhost:8000/v1` |

With a local model, your code never leaves your computer.

## Choose a model

| Interface | How |
|---|---|
| Terminal | `/model`, or `/model <search>` to filter. Recent models come first, then every connected provider's; you can also type any model ID |
| Browser | The model chip under the message box, <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>'</kbd>, or `/model` |
| VS Code | **Choose Model**, or `/model` |

**Refresh models** in the browser's ⋮ menu asks the providers for their lists again.

## What a model needs

The model must support **tool calling** (function calling) reliably, because that is how it reads
files, runs tests and makes changes. Most current hosted models do. Among local models, results vary
with size and quantisation.

Check a model before relying on it:

```text
/test
```

This sends one tool-calling request and tells you whether the model handled it. In VS Code, run **Test
the Chosen Model**.

Pictures you attach reach the model as pictures only if it accepts images; when it doesn't, AlbertCode
tells you.

## Pace

| Pace | What runs | Use it for |
|---|---|---|
| **thorough** (default) | An independent security review and an independent quality review on every governed change | Changes others will rely on |
| **fast** | No reviews: about half the model calls | Quick solo iteration |

The checks, the contract and both approvals apply at either pace. Switch with `/pace fast` or `/pace
thorough`, or set it on a profile with `albertcode configure --pace fast`.

## Where your keys are kept

Keys are kept on your computer by your system's own protection (the macOS Keychain, Windows data
protection or your Linux keyring), and are sent only to the provider they belong to. They are never
given to the commands AlbertCode runs, and never shown to a model. See the
[security model](security.md).

| To | Terminal | VS Code |
|---|---|---|
| Remove one key | `/disconnect` | **Disconnect a Provider** |
| Remove every key | `/disconnect all` | **Remove All Saved Keys** |

In the browser, **Models and keys** in the ⋮ menu has the same, plus the advanced settings.

Updating AlbertCode clears saved keys the first time the new version starts: run `/connect` again.

## Profiles (the older way)

Before `/connect`, models were set up as named profiles. They still work, and suit scripts and shared
services:

```bash
albertcode configure --name local --provider local --base-url http://localhost:11434/v1 --model <model>
albertcode --profile local
```

See [Terminal](terminal.md#profiles-the-older-way).

## Privacy and your provider

To work on your code, AlbertCode sends the model the parts of your repository the task needs. That
data goes to the provider you chose, under that provider's terms, and nowhere else. To keep your code
entirely on your computer, use a local model. See [PRIVACY.md](../PRIVACY.md).
