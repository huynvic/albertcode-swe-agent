# VS Code

The AlbertCode extension brings the same agent into VS Code: a chat panel in the activity bar,
plans and diffs in the editor, and every setting in the command palette. It uses the AlbertCode
installed on your computer, so install AlbertCode first.

## Install the extension

1. Install AlbertCode ([Installation](installation.md)) and run `albertcode` once in a terminal, so
   its service is running.
2. Download `albertcode-<version>.vsix` from the
   [latest release](https://github.com/huynvic/albertcode-swe-agent/releases/latest).
3. In VS Code, open **Extensions**, then **⋯ → Install from VSIX…**, and choose the file.
4. The AlbertCode icon appears in the activity bar. Click it to open the panel.

Update the extension the same way when you update AlbertCode: the two are released together.

## The panel

```text
┌ ● Ready · notes                         ☰ Chats  + New chat ┐
│                                                           │
│   the conversation: questions, answers, plans, steps,     │
│   results and approvals                                   │
│                                                           │
│ ┌ Governed │ Direct │ Ask only ┐  (Ask each write │ Auto-approve) │
│ │ Ask, or describe a change…                     ⏎      │ │
│ └────────────────────────────────────────────────────────┘ │
└───────────────────────────────────────────────────────────┘
```

- **The status line** says whether the service is reachable and which folder Albert works in.
- **Chats** lists your conversations; **New chat** starts one. A run keeps going when you start a
  new chat: its row in **Chats** shows when it is done or waiting for you.
- **Governed**, **Direct** and **Ask only** choose the [mode](how-it-works.md#modes). In Direct,
  **Ask each write** or **Auto-approve** says how writes are approved.
- The message box: <kbd>Enter</kbd> sends. Paste or drop files and screenshots to attach them.

Plans and results open in the editor, where you can read them in full, and the decision waits in the
panel beside them:

| Moment | Your choices |
|---|---|
| A plan is ready | **Approve plan**, **Ask for changes**, **Reject** |
| A direct write or command | **Approve** / **Run it**, **Approve all** / **Run, and stop asking**, **Decline** |
| The change is ready | **Accept changes**, **Ask for changes**, **Roll back** (discards the isolated copy) |
| A review blocked it | **Ask for changes**, **Discard** |

See [Chatting with Albert](chat.md) for what each one does.

## Choosing the folder

Albert works in the folder open in VS Code: with several open, the one holding the file you are
editing, else the first. To work in another folder or a subfolder, right-click it in the Explorer and
choose **AlbertCode SWE Agent: Open Here**.

## Slash commands in the panel

| Command | What it does |
|---|---|
| `/plan <request>`, `/do <request>` | Start a governed or a direct change |
| `/model [search]`, `/models` | Choose a model |
| `/connect [provider]` | Connect a provider |
| `/new` | New chat |
| `/chats`, `/sessions` | Open the list of chats |
| `/mcp [name]`, `/connectors` | MCP servers; the connector gallery |
| `/commands`, `/agents`, `/agent <name>`, `/plugins` | Custom commands, agents and plugins |
| `/name …` | Run one of your custom commands |
| `/server:prompt …` | Use an MCP server's prompt |

## Commands

Open the command palette (<kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Shift</kbd> <kbd>P</kbd>) and type
*AlbertCode*. The panel's title bar has the most used ones in its **⋯** menu.

| Command | What it does |
|---|---|
| **Start Task** | Ask for a change, as a governed task |
| **Choose Model** | Pick the model for new work |
| **Connect a Provider** | Connect a provider: its key, or a local model's address |
| **Test the Chosen Model** | Check the model can drive AlbertCode |
| **Disconnect a Provider** | Remove one provider's saved key |
| **Remove All Saved Keys** | Remove every saved provider key from this computer |
| **Task History** | Every task, to open one |
| **Evidence Ledger** | The record of what each task did, and whether it is intact |
| **Clear Task History** | Delete the task history |
| **Show the Contract** | The [contract](contract.md) in force for this folder |
| **Write a Contract** | Write one from a description |
| **Contract History** | Every version of the contract; restore one |
| **What It Has Learned Here** | The repository's memory (`.albertcode/memory.md`) |
| **Tools and Skills** | Switch extra tools and skills on or off |
| **Add a Tool** | Save one of your commands as a tool |
| **Remove a Saved Tool** | Remove a saved tool |
| **MCP Servers** | Your MCP servers: their state, tools, sign-in |
| **Add an MCP Server** | Add a server: a local command or a remote URL |
| **Browse MCP Connectors** | The connector gallery |
| **Use an MCP Prompt or Resource** | Send a server's prompt, or attach one of its resources |
| **Language Checks** | Which languages edits are checked in; install a checker |
| **Custom Commands** | Your commands; **New command…** makes one in four questions |
| **Choose Agent** | Work as a custom agent; **New agent…** makes one |
| **Plugins** | Install, update, switch on or off, remove, or make a plugin |
| **Run App** | Start this folder's app and open it (or **Open in Browser**, **Restart**, **Stop**) |
| **Stop App** | Stop the app |
| **Documentation** | Open this documentation on the web |
| **Check Service** | Whether the AlbertCode service is reachable |
| **Configure Enterprise API Key** | The key for a shared AlbertCode service your organisation runs |
| **Open Here** | Work in the folder you right-clicked (Explorer menu) |

## Settings

| Setting | Default | Meaning |
|---|---|---|
| **AlbertCode SWE Agent: Provider** | `backend-default` | The model profile for new tasks. With `backend-default` you choose from the service's profiles and the model picked with **Choose Model** |
| **AlbertCode SWE Agent: Server Url** | The service on this computer | Change it only to use a shared AlbertCode service |

## When it can't reach AlbertCode

The status line says **Service unreachable**: run `albertcode` once in a terminal to start the
service, then run **Developer: Reload Window**. After updating AlbertCode, reload the window too. See
[Troubleshooting](troubleshooting.md).
