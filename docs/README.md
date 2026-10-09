# AlbertCode documentation

Everything you need to install, use and operate AlbertCode SWE Agent: every command, page and button,
with examples.

You can read it inside AlbertCode too, offline: **⋮ → Documentation** in the browser interface,
`/docs` in the terminal, or **Documentation** in VS Code.

## Start here

1. [**Getting started**](getting-started.md): install, connect a model, and finish a first task in
   about five minutes.
2. [**How AlbertCode works**](how-it-works.md): the service, the modes, a change's two approvals, tasks,
   sessions, evidence, and what AlbertCode keeps where.
3. [**Chatting with Albert**](chat.md): asking, changing, approving, sessions, chats grouped by topic,
   attachments.

## Using AlbertCode

| Guide | What's in it |
|---|---|
| [Using AlbertCode](usage.md) | The short version of everything, with links |
| [Terminal](terminal.md) | `albertcode`: every option, slash command and subcommand, scripting, environment variables |
| [Browser interface](browser.md) | The layout, the ⋮ menu, the command palette, every shortcut, Files and Terminal |
| [VS Code](vscode.md) | Installing the extension, the panel, every command and setting |
| [Models](models.md) | Providers, local models, choosing and testing a model, pace, keys |

## What your app is made of, and what it must do

| Guide | What's in it |
|---|---|
| [Architecture](architecture.md) | What a repository is made of, read from its own files |
| [Requirements](requirements.md) | What the app must do, as a checklist backed by evidence |
| [Preview and browser tests](preview-and-tests.md) | Run the app beside the chat, edit it by clicking, test it in a real browser |

## Control and evidence

| Guide | What's in it |
|---|---|
| [Tasks and evidence](tasks-and-evidence.md) | The task board, a task's evidence, the evidence ledger, compliance exports, memory, language checks |
| [The contract](contract.md) | `albertcode.contract.toml`: what AlbertCode may do in a repository |
| [Security model](security.md) | How your keys, code and data are protected |

## Extending

| Guide | What's in it |
|---|---|
| [Extending](extending.md) | Custom commands, custom agents, saved tools and skills |
| [MCP servers](mcp.md) | Connectors, adding servers, sign-in, prompts and resources |
| [Plugins](plugins.md) | Installing, updating and making plugins; the plugin format |

## Reference

| Guide | What's in it |
|---|---|
| [Installation](installation.md) | Options, updating, uninstalling, requirements |
| [Troubleshooting](troubleshooting.md) | Fixes for installing, running, and building and running systems |
| [FAQ](faq.md) | Short answers |
| [Glossary](glossary.md) | Every term, in one place |

## Find a command

| I want to… | Terminal | Browser | VS Code |
|---|---|---|---|
| Ask a question | Type it | Type it | Type it |
| Make a change with approvals | `/plan …` | `/plan …`, or the **Governed** mode | `/plan …`, or **Governed** |
| Change files directly | `/do …` | `/do …`, or **Direct** | `/do …`, or **Direct** |
| Connect a model | `/connect` | **Connect a provider** | **Connect a Provider** |
| Choose a model | `/model` | <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>'</kbd> | **Choose Model** |
| Start a new conversation | `/new` | <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Shift</kbd> <kbd>O</kbd> | **+** (New chat) |
| Give it a file or screenshot | `/attach <path>` | Paste or drop | Paste or drop |
| See every task | `/tasks` | **Tasks** | **Task History** |
| Read the evidence ledger | `/ledger` | **Evidence ledger** | **Evidence Ledger** |
| Export a change's evidence | `albertcode compliance <task>` | **Export evidence** | |
| Set the repository's limits | `/contract` | **Contract** | **Show the Contract** |
| Add an MCP server | `/mcp add`, `/connectors` | **MCP servers** | **Add an MCP Server** |
| Make a custom command | `/commands new` | **Commands, agents and plugins** | **Custom Commands** |
| Install a plugin | `/plugins install …` | **Plugins** | **Plugins** |
| Run the app | `/preview` | **Preview** | **Run App** |
| Every command | `/help` | <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>K</kbd> | <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Shift</kbd> <kbd>P</kbd> → *AlbertCode* |

## Getting help

- [Troubleshooting](troubleshooting.md) has the fixes for common problems.
- Ask in [Discussions](https://github.com/huynvic/albertcode-swe-agent/discussions).
- Report a bug in [Issues](https://github.com/huynvic/albertcode-swe-agent/issues/new/choose), with
  `albertcode --version` and your operating system. Never include keys, tokens or private code.
