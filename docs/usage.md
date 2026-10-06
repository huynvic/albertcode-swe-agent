# Using AlbertCode

## Three interfaces, one agent

| Interface | Start it | Good for |
|---|---|---|
| Terminal | `albertcode` | Working where you already are |
| Browser | `albertcode --ui` | Reading plans and diffs side by side; several sessions at once |
| VS Code | the AlbertCode panel | Staying in the editor; right-click a folder → *Open Here* |

All three talk to the same local service, so a task started in one can be followed in another.

## Modes

| Mode | What happens | Use it when |
|---|---|---|
| **Governed** (default) | You approve a plan, it works in an isolated copy, runs your tests and reviews the result, then you approve the diff | Changes you care about |
| **Direct** | It works in your real files and asks before each write (or, with `auto`, doesn't ask). Needs Git. | Pairing on something you're watching |
| **Ask** | It answers questions and changes nothing | Understanding a codebase |

Switch with `/mode`, or start one request in a given mode with `/plan` or `/do`.

## Files panel

In the browser interface, **Files** in the top bar shows the open repository's files beside the
chat. Click a folder to open it, and a file to read it in the viewer; **Back to Files** returns.

| To | Do this |
|---|---|
| Make a file or folder | **New file** or **New folder** in the toolbar. It goes into the selected folder |
| Rename | Right-click → **Rename**, or select it and press F2 |
| Duplicate | Right-click → **Duplicate**. The copy is called "name copy" |
| Copy or move | Right-click → **Copy** or **Cut**, then right-click a folder → **Paste** (or Ctrl/⌘ C, X and V) |
| Copy a path | Right-click → **Copy path** (full) or **Copy relative path** |
| Delete | Right-click → **Move to Trash**, or Delete (⌘⌫ on a Mac), then confirm |

What it will not do, by design: work outside the open repository or through a link; show or change
Git's own folder; open or change a file that looks like it holds secrets (shown with a lock);
overwrite anything. Deleted items go to the Trash (the Recycle Bin on Windows), where you can restore
them. The panel is offered only on your own computer, and every change is recorded in AlbertCode's
ledger.

## Approvals

In governed mode there are two:

1. **The plan.** You see the goal, the files it expects to change, the steps, the test plan, the
   risk and how to roll back. Rejecting it discards the task.
2. **The result.** You see the diff, the test and check results, and the review. Accepting applies
   the change to your repository. Acceptance is refused if a file it changes was edited since the
   task started.

Accepted changes are ordinary edits in your working tree: review them with `git diff`, commit them,
and undo them with Git.

## Terminal commands

| Command | |
|---|---|
| `/connect [provider]` | Connect a provider: its key, or the address of a local model |
| `/model [search]` | Choose a model |
| `/test [model]` | Check a model can drive AlbertCode |
| `/plan <request>` | Start a governed change |
| `/do <request>` | Work directly in your files, asking before each write |
| `/mode [governed\|direct\|auto\|ask]` | How plain requests are handled |
| `/chat [message]` | Talk to the model without starting a task |
| `/attach <paths>` | Give it files or screenshots |
| `/workspace` | Show or change the repository |
| `/tasks` | Recent tasks |
| `/preview` | Run this repository's app at an address of its own |
| `/commands`, `/agents` | Your custom commands and agents ([Extending](extending.md)) |
| `/mcp`, `/connectors` | MCP servers ([Extending](extending.md)) |
| `/ledger` | The record of what each task did, and whether it is intact |
| `/status` | The repository and model in use |
| `/help` | Every command |
| `/exit` | Leave (the service keeps running; `albertcode stop` stops it) |

## Scripting

Every step is also a subcommand, so AlbertCode fits a script or CI job:

```bash
TASK=$(albertcode create "Add tests for the billing module" --workspace ./repo | jq -r .id)
albertcode show    "$TASK"     # the task, as JSON
albertcode approve "$TASK"     # approve the plan
albertcode diff    "$TASK"     # the change
albertcode accept  "$TASK"     # apply it
```

`albertcode reject` discards a task, and `albertcode --help` lists every subcommand.

## Attachments

Paste or drop screenshots, logs and documents into the browser or VS Code, or use `/attach` in the
terminal. Images reach the model as images, if the model accepts them. If it doesn't, AlbertCode
tells you.

## Checking your setup

```bash
albertcode doctor
```

This shows which build tools AlbertCode can see, and where it found them.
