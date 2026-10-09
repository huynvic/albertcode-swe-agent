# Using AlbertCode

The short version of everything. Each section links to its full guide.

## Three interfaces, one agent

| Interface | Start it | Good for | Guide |
|---|---|---|---|
| Terminal | `albertcode` | Working where you already are; scripts and CI | [Terminal](terminal.md) |
| Browser | `albertcode --ui` | Plans and diffs side by side; several sessions at once | [Browser interface](browser.md) |
| VS Code | The AlbertCode panel | Staying in the editor; right-click a folder → *Open Here* | [VS Code](vscode.md) |

All three talk to the same local service, so a task started in one can be followed in another. See
[How AlbertCode works](how-it-works.md).

## Modes

| Mode | What happens | Use it when |
|---|---|---|
| **Governed** (default) | You approve a plan, it works in an isolated copy, runs your tests and reviews the result, then you approve the diff | Changes you care about |
| **Direct** | It works in your real files and asks before each write (or, with *auto*, doesn't ask). Needs Git | Pairing on something you're watching |
| **Ask only** | It answers questions and changes nothing; a change is offered for your go | Understanding a codebase |

Switch with `/mode`, or start one request in a given mode with `/plan` or `/do`. See
[Chatting with Albert](chat.md).

## Approvals

In governed mode there are two:

1. **The plan.** The goal, the files it expects to change, the steps, the test plan, the risk and how
   to roll back. Approve it, ask for changes, or reject it.
2. **The result.** The diff, the test and check results, and the reviews. Accept it, ask for changes,
   or discard it. Acceptance is refused if a file it changes was edited since the task started.

Accepted changes are ordinary edits in your working tree: review them with `git diff`, commit them,
and undo them with Git.

## Everyday commands

| Command | |
|---|---|
| `/connect`, `/model`, `/test` | Connect a provider, choose a model, check it ([Models](models.md)) |
| `/plan <request>`, `/do <request>` | Start a governed or a direct change |
| `/mode [governed\|direct\|auto\|ask]` | How plain requests are handled |
| `/new` | A fresh conversation |
| `/attach <paths>` | Give it files or screenshots |
| `/tasks`, `/ledger` | Recent tasks; the evidence ledger ([Tasks and evidence](tasks-and-evidence.md)) |
| `/commands`, `/agents`, `/plugins`, `/tools` | Your extensions ([Extending](extending.md)) |
| `/mcp`, `/connectors` | MCP servers ([MCP servers](mcp.md)) |
| `/contract` | The repository's boundary ([The contract](contract.md)) |
| `/help` | Every command |

The [terminal reference](terminal.md) lists all of them, with examples. In the browser,
<kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>K</kbd> opens the command palette.

## The pages of the browser interface

| Page | What it is for |
|---|---|
| [Architecture](architecture.md) | What the repository is made of, read from its files |
| [Requirements](requirements.md) | What the app must do, as a checklist with evidence |
| [Preview and browser tests](preview-and-tests.md) | Run the app beside the chat, edit it by clicking, and test it in a browser |
| [Tasks and the evidence ledger](tasks-and-evidence.md) | Every task, and the record of what each did |
| [Files and Terminal](browser.md#files) | The repository's files, and a real shell, beside the chat |

## Scripting

Every step is also a subcommand, so AlbertCode fits a script or CI job:

```bash
TASK=$(albertcode create "Add tests for the billing module" --workspace ./repo | jq -r .id)
albertcode show    "$TASK"     # the task, as JSON
albertcode approve "$TASK"     # approve the plan
albertcode diff    "$TASK"     # the change
albertcode accept  "$TASK"     # apply it
```

`albertcode reject` discards a task, and `albertcode --help` lists every subcommand. See
[Terminal](terminal.md#subcommands).

## Attachments

Paste or drop screenshots, logs and documents into the browser or VS Code, or use `/attach` in the
terminal. Images reach the model as images, if the model accepts them. If it doesn't, AlbertCode
tells you. See [Attachments](chat.md#attachments).

## Checking your setup

```bash
albertcode doctor
```

This shows which build tools AlbertCode can see, and where it found them.
