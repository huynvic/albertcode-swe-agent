# Extending AlbertCode

You can extend AlbertCode without touching its code, in five ways:

| | What it is | Kept in |
|---|---|---|
| [Custom commands](#custom-commands) | A message you send often, used by name: `/review src/cart.py` | Markdown files |
| [Custom agents](#custom-agents) | A role Albert works as, which can only take tools away | Markdown files |
| [Tools and skills](#tools-and-skills) | One of your commands saved as a tool; a project convention written down | JSON, Markdown |
| [Plugins](plugins.md) | Commands, agents and MCP servers installed together, shareable | A folder or Git address |
| [MCP servers](mcp.md) | Outside tools: Git, Playwright, databases, your company's services | `/mcp`, `/connectors` |

[examples/](../examples/README.md) has ready-to-copy files.

None of them can widen what AlbertCode is allowed to do: the mode, the [contract](contract.md) and both
approvals apply to everything an extension does.

## Custom commands

A command is a prompt you write once and call by name. It is a Markdown file:

```markdown
---
description: Review a file for correctness bugs
agent: reader          # optional: run as this custom agent
mode: ask              # optional: ask, governed or direct
argument-hint: <file>
---
Review $ARGUMENTS for correctness bugs, not style. Start with $1.
```

Saved as `.albertcode/commands/review.md`, it is `/review`:

```text
› /review src/cart.py
```

| Where | Applies to |
|---|---|
| `.albertcode/commands/<name>.md` in a repository | That repository; shared when you commit it |
| `commands/<name>.md` in your AlbertCode settings folder | Every repository, for you only |
| A switched-on plugin's `commands/` | Every repository; also reachable as `/plugin:name` |

- `$ARGUMENTS` is everything typed after the command; `$1` to `$9` are its words, quoted as a shell
  would. With neither in the text, what you typed is added at the end.
- When two places define the same name, the repository wins, then your settings folder, then plugins.
  A command can never take a built-in's name: `/plan` is always `/plan`.
- A file that is a link, larger than 16 KB or empty is refused, with the reason.
- **A command is text.** Running one runs no program and reads no file: what it expands to is sent as
  your own message, shown in full under a line naming the command and its file. The mode and the
  approvals apply as if you had typed it.

**Make one without writing the file:** `/commands new` in the terminal, **New command** in the browser
(**Commands, agents and plugins**), or **Custom Commands → New command…** in VS Code. Each asks for a
name, what it does, what it sends (showing what `/name src/cart.py` would send as you type), the agent
it works as, the mode, and whether it belongs to this repository or only to you.

## Custom agents

An agent is a role a task works as. It can only narrow what AlbertCode is allowed to do, never widen
it:

```markdown
---
description: Reads and reports; never edits
tools: read, run
---
You are reviewing someone else's change. Find correctness bugs, with file and line.
```

| `tools` group | Allows |
|---|---|
| `read` | Reading, searching and understanding the repository |
| `edit` | Writing, moving, deleting and renaming files |
| `run` | Commands, tests and services |
| `browser` | Driving a web page and comparing screenshots |
| `web` | Reading documentation and searching the web |
| `images` | Drawing and converting images and diagrams |
| `mcp`, `custom` | MCP servers' tools; your saved tools |
| `all` | No narrowing |

Keep agents in `.albertcode/agents/` in a repository, in `agents/` in your settings folder, or in a
plugin. Choose one with:

| Interface | How |
|---|---|
| Terminal | `/agent reader`; `/agent default` goes back |
| Browser | The agent chip beside the mode, or `/agent reader` |
| VS Code | **Choose Agent** |
| A custom command | Its `agent:` line, for that message only |

- With no `tools` line, an agent changes only the instructions.
- An agent that cannot edit answers questions only: a change asked of it is refused before anything
  starts, with the reason.
- A tool outside its set is not offered; if the model asks for it anyway, the call is refused and
  recorded.
- The agent is fixed when a task starts: the task records its name, tools and file, and never reads
  the file again.

**Make one:** `/agents new`, **New agent** in the browser, or **Choose Agent → New agent…** in VS Code.
Untick *Edit files* and it says plainly that the agent will answer questions but cannot make changes.

## Tools and skills

**Tools and skills**, in the browser's ⋮ menu (`/tools` in the terminal, **Tools and Skills** in VS
Code), lists what Albert may use in this repository:

- **Built-in tools** are always on.
- **Saved tools** are your own commands, saved so the model can call them by name.
- **Skills** are project conventions written down, kept next to the code.

Saved tools and skills are **off until you switch them on**, and the repository's
[contract](contract.md) decides whether they may be switched on at all.

### Saved tools

Every project has commands that matter and that a model would never guess: `make check`, the codegen
step after a schema change, the end-to-end run with the right flags. Save one and the model sees it as
`custom.<name>`, with a sentence saying when to use it:

```json
{"name": "test_one", "description": "Run one test file",
 "command": ["python", "-m", "pytest", "-q", "{path}"],
 "parameters": [{"name": "path", "description": "Path to the test file"}]}
```

A saved tool is a fixed command with named holes, each filled with exactly one argument: never split,
never passed through a shell. It runs under the same command rules as anything else: saving a tool that
runs a command AlbertCode does not allow is refused at once. Make one with **Save one of your commands
as a tool** → **Save tool** (browser, in **Tools and skills**), `/tools new` (terminal) or **Add a
Tool** (VS Code).

### Skills

A skill is a Markdown file in `.albertcode/skills/`:

```markdown
---
name: migrations
description: How this project writes database migrations
when: the change adds or alters a table
---
Always add a migration under `db/migrations`, never edit an applied one.
```

Skills are read from your repository, never from Albert's isolated copy. A skill changes what the
model is **told**, never what it is **allowed to do**.

### Switching them on

| Interface | How |
|---|---|
| Browser | Tick it in **Tools and skills** |
| Terminal | `/tools`, then its number (numbers toggle; `all` and `none` set everything) |
| VS Code | **Tools and Skills** |

Anything the contract bars is shown with the reason. Where the repository has a contract, **Allow in
contract** (`/tools allow <id>`) adds it to the contract after showing you the exact line.

## MCP servers

AlbertCode connects to [Model Context Protocol](https://modelcontextprotocol.io) servers, over a local
process or HTTP, including servers that need you to sign in:

```text
/connectors          # pick from a gallery: Git, Playwright, PostgreSQL, web fetch, …
/mcp add             # add any server
/mcp list            # what is connected, and its tools
```

An MCP server's tools go through the same approvals as everything else. See [MCP servers](mcp.md).

## Plugins

A plugin bundles commands, agents and MCP servers in one folder, so a team can share them and anyone
can install them in one step from a folder or an `https` Git address:

```text
/plugins install https://github.com/example/review-kit
```

See [Plugins](plugins.md) for the format and how installing is checked.
