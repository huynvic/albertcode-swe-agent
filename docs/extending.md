# Extending AlbertCode

You can extend AlbertCode in three ways, none of which needs access to its source: custom commands,
custom agents and MCP servers. [examples/](../examples/README.md) has ready-to-copy files.

## Custom commands

A command is a prompt you write once and call by name: `/review src/cart.py` instead of typing the
same paragraph again. It is a Markdown file:

```markdown
---
description: Review a file for correctness bugs
agent: reader          # optional: run as this custom agent
mode: ask              # optional: ask, governed or direct
argument-hint: <file>
---
Review $ARGUMENTS for correctness bugs, not style. Start with $1.
```

| Where | Applies to |
|---|---|
| `.albertcode/commands/<name>.md` in a repository | That repository; shared when you commit it |
| `commands/<name>.md` in your AlbertCode settings folder | Every repository, for you only |

`$ARGUMENTS` is everything typed after the command; `$1` to `$9` are its words. A command is only
text: running one runs no program and reads no file. The mode you're in and the approval steps apply
as if you had typed the text yourself.

You don't have to write the file by hand. `/commands new` in the terminal, **New command** in the
browser and **Custom Commands → New command** in VS Code ask a few questions and write it for you.

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

Keep agents in `.albertcode/agents/` in a repository, or in `agents/` in your settings folder. Choose
one with `/agent <name>`, the agent chip in the browser, or **Choose Agent** in VS Code. An agent
without `edit` answers questions but cannot change anything.

## MCP servers

AlbertCode connects to [Model Context Protocol](https://modelcontextprotocol.io) servers, over a
local process or HTTP, including servers that need you to sign in.

```text
/connectors          # pick from a catalogue: Git, Playwright, PostgreSQL, web fetch, …
/mcp add             # add any server
/mcp list            # what is connected, and its tools
```

An MCP server's tools go through the same approvals as everything else.
