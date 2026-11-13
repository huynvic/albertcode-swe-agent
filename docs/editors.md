# Other editors

AlbertCode is not only in the terminal, the browser and VS Code. The same agent, with the same plans, approvals,
isolated copy, checks and sessions, runs in two more kinds of editor:

| Editor | How | Read |
|---|---|---|
| **Cursor, Windsurf, VSCodium** and other editors built on VS Code | The AlbertCode extension, the same file as for VS Code | [Editors built on VS Code](#editors-built-on-vs-code) |
| **Zed, JetBrains IDEs** (IntelliJ IDEA, PyCharm, WebStorm, GoLand and the rest), **Neovim, Emacs, Sublime Text** and other editors that speak the Agent Client Protocol | `albertcode acp`, started by the editor | [Editors that speak the Agent Client Protocol](#editors-that-speak-the-agent-client-protocol) |

Either way the editor is one more way into the same service: a session started in an editor shows in the terminal
and the browser, and the other way round.

## Editors built on VS Code

Cursor, Windsurf, VSCodium and other editors built on VS Code install the AlbertCode extension from the same
`.vsix` file as VS Code, and it works the same way: see [VS Code](vscode.md) for the panel and its commands.

1. Install AlbertCode ([Installation](installation.md)) and run `albertcode` once in a terminal.
2. Download `albertcode-<version>.vsix` from the
   [latest release](https://github.com/huynvic/albertcode-swe-agent/releases/latest).
3. In the editor, open **Extensions**, then **⋯ → Install from VSIX…**, and choose the file. Or, from a terminal:

```bash
cursor --install-extension albertcode-1.56.0.vsix     # Cursor
windsurf --install-extension albertcode-1.56.0.vsix   # Windsurf
codium --install-extension albertcode-1.56.0.vsix     # VSCodium
```

The extension uses only VS Code's standard features and needs a version built on VS Code 1.95 or later, which
every current release of these editors is.

## Editors that speak the Agent Client Protocol

The [Agent Client Protocol](https://agentclientprotocol.com) is how an editor runs a coding agent it did not
build. The editor starts `albertcode acp`, and AlbertCode answers in the editor's own agent panel.

### Before you start

1. Install AlbertCode ([Installation](installation.md)).
2. Choose a model: run `albertcode --setup` in a terminal, or `albertcode` and type `/model`. The editor uses the
   model AlbertCode is set to; `albertcode models use <provider:model>` changes it, for the editor and every new
   session.

If no model is chosen yet, the editor asks you to sign in the first time you start a thread, with **Set up
AlbertCode**: it opens a terminal that runs `albertcode --setup`, and the editor carries on once a model is chosen.
A new version of AlbertCode starts with no model chosen, so the editor asks again after an upgrade.

### Zed

Open the agent settings (**agent: open settings**), go to **External Agents**, choose **Add Agent → Add Custom
Agent**, and set it to:

```json
{
  "agent_servers": {
    "AlbertCode": {
      "type": "custom",
      "command": "albertcode",
      "args": ["acp"],
      "env": {}
    }
  }
}
```

Then start a thread in the agent panel and choose **AlbertCode**.

### JetBrains IDEs

In **AI Chat**, open the **⋯** menu and choose **Add Custom Agent**. The IDE opens `~/.jetbrains/acp.json`; add
AlbertCode to it:

```json
{
  "agent_servers": {
    "AlbertCode": {
      "command": "albertcode",
      "args": ["acp"],
      "env": {}
    }
  }
}
```

Choose **AlbertCode** in AI Chat's agent list. No JetBrains AI subscription is needed for an agent of your own.

### Neovim, Emacs, Sublime Text and others

Each has a plugin that speaks the Agent Client Protocol: for Neovim, CodeCompanion or avante.nvim; for Emacs,
agent-shell; for Sublime Text, its ACP plugin. In the plugin's settings for an agent of your own, set the command
to `albertcode` and its arguments to `acp`. The protocol's site lists every
[editor that supports it](https://agentclientprotocol.com/overview/clients).

### If the editor cannot find `albertcode`

An editor started from the Dock, the Start menu or a launcher may not see the `PATH` your terminal has. Use the
command's full path instead of `albertcode`:

| On | Usually | To be sure, run |
|---|---|---|
| macOS and Linux | `~/.local/bin/albertcode` (written out in full: the editor may not expand `~`) | `which albertcode` |
| Windows | `%USERPROFILE%\.local\bin\albertcode.exe` (written out in full) | `where albertcode` |

## What you get in the editor

| In AlbertCode | In the editor |
|---|---|
| **Choosing a model** | The editor's sign-in: **Set up AlbertCode** opens a terminal to choose one |
| **Modes** (Governed, Direct asking each write, Direct auto, Ask only) | The editor's mode picker. A new session starts in Governed |
| **Approval 1: the plan** | A question: **Approve and build**, or **Reject the plan**. The plan is shown with it, and its steps become the editor's plan |
| **A write in Direct** | A question: **Allow**, **Allow the rest of this task**, or **Decline** |
| **Approval 2: the diff** | A question, with the change shown as the editor's own diff: **Accept into your files**, or **Discard the change** |
| **A change offered in Ask only** | A question: plan it, do it directly, or not now |
| **What Albert reads, searches, edits and runs** | The editor's list of steps, each running, then done or failed |
| **`/plan` and `/do`** | The same commands, typed after `/` |
| **Files you mention or attach** | Named in the message (Albert reads them in the repository), or quoted when the editor sends their contents; pictures are attached |
| **Sessions** | Listed and opened again in the editor, with their conversation; the same sessions as the terminal and browser |

A question answered in the terminal or browser first is withdrawn from the editor. Stopping the editor's prompt
stops the work, as **Stop** does in the browser.

A change the reviews blocked can only be discarded in the editor: accepting it needs an administrator's written
reason, which the terminal and browser ask for.

The editor's own MCP servers are not passed to AlbertCode, which uses its own: see [MCP servers](mcp.md).

## If it does not work

| What you see | What to do |
|---|---|
| The editor says the agent could not start | Run `albertcode acp` in a terminal. It waits silently for an editor: that is right (<kbd>Ctrl</kbd> <kbd>C</kbd> ends it). An error there says what is wrong. If the command is not found, see [If the editor cannot find `albertcode`](#if-the-editor-cannot-find-albertcode) |
| "Authentication required" or "Choose a model first" | Choose **Set up AlbertCode** in the editor, or run `albertcode --setup` in a terminal |
| "AlbertCode's service could not be reached" | `albertcode status`, then `albertcode` to start it |
| An answer never comes | Open the same session in the terminal (`albertcode --resume`) or the browser: what it is doing is shown there |

Messages from `albertcode acp` itself go to standard error, which most editors keep in their log for agents, never
into the conversation.
