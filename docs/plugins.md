# Plugins

A plugin shares [custom commands](extending.md#custom-commands), [custom agents](extending.md#custom-agents)
and [MCP servers](mcp.md) in one folder, so a team can use them in every repository, or hand them to a
colleague. It installs the same way from the browser, the terminal and VS Code.

## Install a plugin

Give a folder on your computer, or an `https` Git address:

| Interface | How |
|---|---|
| Terminal | `/plugins install <folder or https address>` |
| Browser | **Commands, agents and plugins** (⋮ menu) → **Plugins**: type the folder or address, then **Look at it** |
| VS Code | **Plugins** → **Install a plugin…** |

```text
/plugins install https://github.com/example/review-kit
/plugins install ~/code/review-kit
```

**You see what it adds before anything is installed:** every command (as `/review-kit:name`), every
agent and the tools it may use, every MCP server with the exact command it runs or the address it
reaches, and the files it will leave behind. Nothing is installed until you say yes, and what is
installed is exactly what you were shown: if the plugin changed in between, the install is refused and
you look again.

Installed plugins work in every repository, for you. They are kept in your AlbertCode settings folder,
never in a repository a task could edit.

## Manage plugins

| Terminal | Browser and VS Code | What it does |
|---|---|---|
| `/plugins` | **Plugins** | What is installed |
| `/plugins update <name>` | **Check for updates** | Read it again from where it came from, show what would change, and update on your yes |
| `/plugins disable <name>`, `/plugins enable <name>` | **Turn off**, **Turn on** | Switch it off or on (its MCP servers too) |
| `/plugins remove <name>` | **Remove** | Remove it, with its MCP servers |
| `/plugins new <name>` | **New plugin** | Make one (below) |

## Make a plugin

**New plugin** (browser and VS Code) or `/plugins new <name>` makes a plugin folder with its
`plugin.json`, a README, and this repository's commands and agents, or an example of each when it has
none. Push the folder to a Git host, and anyone can install it from its address. Raise `version` when
you change it, so the update screen says so.

### The folder

```text
review-kit/
  plugin.json          the manifest (required)
  README.md            optional; copied in
  LICENSE              optional; copied in
  commands/*.md        custom commands
  agents/*.md          custom agents
```

Nothing else is read. Any other file (a script, a binary, a hook, a skill, a tool) is left behind at
install, and the person installing is told which ones. **No part of a plugin is ever run**, except the
MCP servers it declares, and only after the person has seen exactly what each one runs.

Limits: no symbolic links, no file over 64 KB, at most 300 files and 4 MB in all, at most 8 MCP
servers. A plugin must bring at least one command, agent or MCP server.

### plugin.json

```json
{
  "spec": 1,
  "name": "review-kit",
  "version": "1.2.0",
  "description": "Review commands and a dependency auditor",
  "author": "Platform team",
  "homepage": "https://github.com/example/review-kit",
  "albertcode": ">=1.31",
  "mcp": {
    "docs": {
      "command": ["npx", "-y", "@example/docs-mcp"],
      "environment": {"DOCS_TOKEN": "{env:DOCS_TOKEN}"}
    }
  }
}
```

| Field | Required | Meaning |
|---|---|---|
| `name` | yes | Lower-case letters, digits and dashes, up to 24. Its commands are reachable as `/name:command` |
| `version` | no | The plugin's own version, shown before installing and when updating |
| `description` | no | One line, up to 300 characters |
| `author`, `homepage` | no | Shown on the install screen. `homepage` must be `https` |
| `albertcode` | no | The AlbertCode versions it works with: `>=1.31`, `>=1.31, <2`, `==1.31`. Outside the range, it is refused with the reason |
| `spec` | no | `1`. A manifest written for another version of this format is refused rather than misread |
| `mcp` | no | MCP servers, by name (below) |
| `$schema` | no | A schema address for your editor. AlbertCode ignores it |

Any other field is refused, naming it, so a typo such as `"descripton"` is said rather than silently
ignored.

### commands/*.md and agents/*.md

Exactly the format of `.albertcode/commands/` and `.albertcode/agents/`: see
[Extending](extending.md). A plugin's command is always reachable as `/plugin:name`, and also as
`/name` unless the repository or you have a command of that name, which wins.

### mcp

Each entry is an MCP server, added as `<plugin>-<name>` (so `review-kit-docs` above) and removed with
the plugin. Switching the plugin off switches its servers off.

| Field | Meaning |
|---|---|
| `type` | `local` (runs a command here) or `remote` (reaches a URL). Optional: `remote` when `url` is given |
| `command` | A local server's command, as a list of words |
| `environment` | Variables for a local server. Use `{env:NAME}` for the person's own value |
| `url` | A remote server's `http(s)` address |
| `headers` | Headers for a remote server. Use `{env:NAME}` for a token |
| `timeout` | Milliseconds, 1000 to 600000 |

A plugin may not set a working folder or OAuth client secrets. **Never put a secret in a plugin**: write
`{env:NAME}` and say in the README which variable to set. A plugin never replaces a server you set up
yourself: if the name is taken, the install screen says so and the install is refused until you rename
yours.

## What is checked

1. **Look.** AlbertCode reads the folder, or makes a shallow `https` clone (no other transport, no
   submodules, no hooks, no prompts), and checks everything above.
2. **Install.** Only on your yes, and only if the plugin is still exactly what you were shown.
3. Installing, updating, switching on and off and removing are offered only by AlbertCode running for
   one person on their own computer, from its own page, and each is recorded in the evidence ledger.

Installing grants nothing by itself: a command is text you send by name, an agent only narrows the
tools, and an MCP server's tools are governed like any other's.
