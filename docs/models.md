# Models

AlbertCode handles the engineering workflow: the plan, the isolated copy, the tests, the review and
the approvals. The model you choose does the reasoning. You can change models at any time.

## Supported providers

| Provider | What you need |
|---|---|
| OpenAI | An API key |
| Anthropic | An API key |
| Kimi (Moonshot) | An API key |
| Hugging Face | A token. Open-weight models run through Hugging Face's inference router. |
| OpenRouter | An API key. Gives access to many vendors' models. |
| Any OpenAI-compatible service | Its address and, if it needs one, a key |
| A model on your machine | Ollama, LM Studio, vLLM or another OpenAI-compatible local server |

Connect one with `/connect` in the terminal, or **Connect a provider** in the browser or VS Code.
AlbertCode checks the key or address works before saving it, and shows the provider as connected
only once that check has passed.

## What a model needs

The model must support **tool calling** (function calling) reliably, because that is how it reads
files, runs tests and makes changes. Most current hosted models do. Among local models, results vary
with size and quantisation.

Check a model before relying on it:

```text
/test
```

This sends one tool-calling request and tells you whether the model handled it.

## Where your keys are kept

Keys are stored on your machine, in AlbertCode's settings folder, and are sent only to the provider
they belong to. `/disconnect` removes one key, and `/disconnect all` removes every saved key.

## Privacy and your provider

To work on your code, AlbertCode sends the model the parts of your repository the task needs.
That data goes to the provider you chose, under that provider's terms, and nowhere else. To keep your
code entirely on your machine, use a local model. See [PRIVACY.md](../PRIVACY.md).
