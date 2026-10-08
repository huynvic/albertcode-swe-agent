# MCP servers

[Model Context Protocol](https://modelcontextprotocol.io) servers give Albert outside tools: Git,
a browser, a database, documentation, your company's own services. AlbertCode connects to servers that
run on your computer (a local command) and servers on the web (a URL), including ones that need you to
sign in.

## The quickest way: connectors

**Connectors** is a gallery of ready-made servers, each added in a couple of answers:

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| Git (`git`) | Read and search a local Git repository: status, diffs, log, branches | The repository |
| Filesystem (`filesystem`) | Read, write and search files, only inside the folders you name | The folders |
| Fetch (`fetch`) | Fetch a web page as Markdown | |
| Playwright (`playwright`) | Drive a real browser: open pages, click, type, read the screen, take screenshots | |
| Chrome DevTools (`chrome-devtools`) | Inspect a live Chrome: console, network, performance traces and the DOM | |
| PostgreSQL (`postgres`) | Read-only SQL, schema details and query plans for one database | The database address (`uri`) |
| AWS Documentation (`aws-docs`) | Search and read AWS documentation | |
| Hugging Face (`huggingface`) | Search models, datasets, Spaces and papers | |
| Memory (`memory`) | A knowledge graph the agent keeps notes in across sessions | |
| Sequential Thinking (`sequential-thinking`) | A place to work through a hard problem step by step | |
| Time (`time`) | Current time and time-zone conversion | |
| Everything (`everything`) | The protocol's reference server, for trying MCP out | |

| Interface | How |
|---|---|
| Terminal | `/connectors`, or `/connectors postgres` to search; `/mcp install <id> key=value` adds one without questions |
| Browser | **MCP servers** (⋮ menu) → **Browse connectors**, or **Connectors** in the command palette |
| VS Code | **Browse MCP Connectors** |

```text
/mcp install postgres uri=postgresql://localhost:5432/app
/mcp install git repository=.
```

## Add any server

| Interface | How |
|---|---|
| Terminal | `/mcp add`, then answer: a local command, or a remote URL |
| Browser | **MCP servers** → **Add server**: a name, then a **Local command** (its command and environment) or a **Remote URL** (its address, OAuth or headers) |
| VS Code | **Add an MCP Server** |
| A script | `albertcode mcp add …` (below) |

```bash
# A local server: a command AlbertCode starts, with its variables
albertcode mcp add docs --command "npx -y @example/docs-mcp" --env DOCS_TOKEN=xyz

# A remote server that signs you in with OAuth (a browser window opens)
albertcode mcp add tracker --url https://mcp.example.com/mcp

# A remote server that takes a header instead
albertcode mcp add search --url https://search.example.com/mcp --no-oauth --header "Authorization=Bearer xyz"
```

## Signing in

A remote server that needs a sign-in shows **Needs auth**. `/mcp auth <name>` (or **Sign in** in the
browser and VS Code) opens your browser to sign in; the token is kept in your system's key store and
refreshed for you. `/mcp logout <name>` (**Sign out** in the browser) removes it. A server that needs a
client ID registered by hand shows **Needs client ID**: give it as the server's **OAuth client ID**.

## Managing servers

| Terminal | Browser (**MCP servers**, then a server's **Edit**) | What it does |
|---|---|---|
| `/mcp` | The list | Pick one to switch it on or off |
| `/mcp list` | The list | Every server, its status and its tools |
| `/mcp tools <name>` | Its tool switches | Switch single tools on or off |
| `/mcp enable <name>`, `/mcp disable <name>` | Its switch | Switch a server on or off |
| `/mcp connect <name>` | **Reconnect** | Connect again |
| `/mcp debug <name>` | Its details | Why a server is not working: its command, its output, the error |
| `/mcp remove <name>` | **Delete** | Remove a server |

In VS Code, **MCP Servers** offers the same.

| Status | Meaning |
|---|---|
| **Connected · 12 tools · 3 prompts** | Working, with what it offers |
| **Connecting…** | Starting or reaching it |
| **Needs auth** | Sign in with `/mcp auth <name>` |
| **Needs client ID** | The server needs a client registered by hand |
| **Disabled** | Switched off |
| **Failed: …** | With the error; `/mcp debug <name>` says more |

The sidebar's **MCP** chip in the browser shows how many are connected, and the terminal says when a
server connects, drops or wants a sign-in. A server that drops is reconnected by itself.

## Prompts and resources

Servers can offer **prompts** (ready-made requests) and **resources** (documents and data):

```text
/mcp prompts                       # what servers offer
/github:review-pr 128              # use a prompt: /server:prompt arguments
/mcp resources                     # what servers offer
/mcp attach docs docs://api/orders # attach a resource to your next message
```

In the browser, **MCP prompts and resources** in the command palette; in VS Code, **Use an MCP Prompt
or Resource**. A prompt's text is sent as your message, shown in full.

## What a server may do

An MCP server's tools are governed like everything else:

- While Albert plans or answers questions, only tools that read are offered.
- A tool that acts (writes, sends, changes something) needs your approval: **Allow** in the browser and
  VS Code (or **Allow, and stop asking**), `a` in the terminal.
- Every call is recorded in the evidence ledger.
- A [custom agent](extending.md#custom-agents) without the `mcp` group cannot use MCP tools at all.

Servers you add are yours, for every repository. Servers a [plugin](plugins.md) brings are named
`<plugin>-<name>` and removed with the plugin.
