# Browser interface

The browser interface puts the conversation, the plans, the diffs and every page of AlbertCode side
by side. Start it from a terminal:

```bash
cd your-project
albertcode --ui
```

It opens in your default browser, signed in, on the folder you started it in. To make `albertcode`
always open the browser, set `ALBERTCODE_SURFACE=ui`.

If a page ever asks you to open AlbertCode from your terminal, run `albertcode --ui` again: a new
version of AlbertCode signs in again.

## The layout

```text
┌ Sidebar ────────────┬ Top bar: page · Preview · Test · Files · Terminal · System · ⋮ ┐
│ AlbertCode  v1.47   │                                                              │
│ ┌ repository ─────┐ │   The page: Chat, or System, Requirements, Architecture…    │
│ │ N notes  Browse │ │                                                              │
│ │ Boundary  Run   │ │                                     ┌ Side panel ─────────┐  │
│ └─────────────────┘ │                                     │ Preview, Test,      │  │
│ ● New session       │                                     │ Files, Terminal or  │  │
│ Search sessions     │                                     │ a file              │  │
│ TODAY               │                                     └─────────────────────┘  │
│   sessions…         │   ┌ message box · mode · model · attach ─────────────────┐   │
└─────────────────────┴───┴──────────────────────────────────────────────────────┴───┘
```

- **The repository card** at the top of the sidebar: the folder you are working in, with
  **Browse** to choose another, **Boundary** for its [contract](contract.md), and **Run app** to
  start its app with one command.
- **New session** and **Search sessions**, then every session, newest first, grouped by day. See
  [Sessions](chat.md#sessions) and [Chats about one thing](chat.md#chats-about-one-thing).
- **The top bar**: the page you are on, the side panels (**Preview**, **Test**, **Files**,
  **Terminal**), the [**System**](system.md) page, and the **⋮** menu with every other page and setting.
  A pulsing dot on **System** means Albert is working on your system (a build, a verification, a fix);
  a still amber one means that work is waiting for you.
- **The message box** at the bottom of Chat, with the mode chip, the model chip, the agent chip and
  the attach button.

On a narrow window the sidebar folds away behind the **☰** button at the top left.

## Choosing a folder

**Browse** opens **Open a repository**, the folder picker:

- On the left: **Recent** folders, **Places** (your home and its usual folders) and **Storage**
  (your drives).
- The path at the top: click it (or press <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>L</kbd>) to type one.
- **Back**, **Forward** and **Enclosing folder**, and **New folder** to make one here.
- Folders that are Git repositories are marked **Git**.
- Type to filter the list. <kbd>Enter</kbd> goes into the highlighted folder; **Open** (or
  <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Enter</kbd>) chooses it.

| Keys in the picker | What they do |
|---|---|
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>L</kbd> | Type a path |
| <kbd>Alt</kbd> <kbd>←</kbd> / <kbd>Alt</kbd> <kbd>→</kbd> | Back, forward |
| <kbd>Backspace</kbd> | Enclosing folder (when the filter is empty) |
| <kbd>↑</kbd> <kbd>↓</kbd>, <kbd>Enter</kbd> | Move, open a folder |
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Enter</kbd> | Use the highlighted folder |
| Any letter | Filter |
| <kbd>Esc</kbd> | Clear the filter, then close |

**Boundary** also has **Type a path instead**, and **Inspect boundary** to read the folder's contract.

Changing folder puts the current session in the sidebar under the folder it was about; opening it
again goes back to that folder. A run it had going carries on.

## The ⋮ menu

| Group | Item | Opens |
|---|---|---|
| Workspace | **Chat** | The conversation |
| | **Requirements** | [Requirements](requirements.md) |
| | **Architecture** | [Architecture](architecture.md) |
| | **Contract** | [The contract](contract.md): read it, write one, its history |
| | **Tools and skills** | [Tools and skills](extending.md#tools-and-skills) |
| | **Commands, agents and plugins** | [Commands, agents](extending.md) and [plugins](plugins.md) |
| | **Language checks** | [Language checks](tasks-and-evidence.md#language-checks) |
| | **MCP servers** | [MCP servers](mcp.md) |
| | **Models and keys** | [Models](models.md), the advanced settings |
| Assurance | **Tasks** | The [task board](tasks-and-evidence.md#the-task-board) |
| | **Evidence ledger** | The [ledger](tasks-and-evidence.md#the-evidence-ledger) |
| Session | **New session** | A fresh conversation |
| | **Clear this chat** | Empty the session open now |
| Help | **Documentation** | This guide, inside AlbertCode (see [below](#documentation)) |
| Interface | **Command palette** | See below |
| | **Focus mode** | Hide the sidebar and the side panels' chrome |
| | **Light or dark** | Switch the theme |
| | **Refresh models** | Ask the providers for their model lists again |

A dot on the **⋮** button means a task is waiting for you. **System** is not in the menu: it has its own
button in the top bar, next to **Terminal**.

## The command palette

<kbd>Ctrl</kbd> <kbd>K</kbd> (<kbd>⌘</kbd> <kbd>K</kbd> on a Mac) opens the palette: type to find a
command or a session, <kbd>Enter</kbd> to run it.

| Command | Shortcut, or the same as |
|---|---|
| New session | <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Shift</kbd> <kbd>O</kbd> |
| Choose a model | <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>'</kbd> |
| Connect a provider | `/connect` |
| MCP servers | `/mcp` |
| Language checks — which languages each edit is checked in | `/checks` |
| Commands, agents and plugins | `/commands` |
| Each of your custom commands, by name | Puts `/name ` in the message box |
| Work as each of your custom agents | `/agent <name>` |
| Work with no agent | `/agent default` |
| Connectors — add Git, Playwright, PostgreSQL and more | `/connectors` |
| MCP prompts and resources | |
| Choose a folder | **Browse** |
| Mode: Governed — plan, then approve | The mode chip |
| Mode: Direct — ask each write | The mode chip |
| Mode: Direct — auto-approve | The mode chip |
| Mode: Ask only | The mode chip |
| Open tasks | **Tasks** |
| Open requirements | **Requirements** |
| Open system | **System** |
| Open architecture | **Architecture** |
| Open evidence ledger | **Evidence ledger** |
| Open the contract | **Contract** |
| Models and keys (advanced) | **Models and keys** |
| Light or dark | |
| Focus mode | |
| Documentation — every command, page and button, with examples | **Documentation** |

Below the commands, the palette lists your sessions: pick one to open it.

## Slash commands in the browser

Typed in the message box, these are answered by the page and never sent to a model:

| Command | What it does |
|---|---|
| `/model [search]`, `/models` | Choose a model |
| `/connect [provider]` | Connect a provider |
| `/new` | New session |
| `/sessions [search]` | Find a session (opens the palette) |
| `/help` | Open the command palette |
| `/commands`, `/agents`, `/plugins` | Commands, agents and plugins |
| `/agent <name>`, `/agent default` | Work as a custom agent; go back to none |
| `/mcp [name]`, `/connectors [search]` | MCP servers; the connector gallery |

`/plan <request>` and `/do <request>` start a change ([Chatting with Albert](chat.md#choosing-for-one-request-plan-and-do)),
`/name …` runs one of your custom commands, and `/server:prompt …` uses an MCP prompt.

## Keyboard shortcuts

| Keys | Where | What they do |
|---|---|---|
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>K</kbd> | Anywhere | Command palette |
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>'</kbd> | Anywhere | Choose a model |
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Shift</kbd> <kbd>O</kbd> | Anywhere | New session |
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Enter</kbd> | Message box | Send |
| <kbd>Esc</kbd> | A dialog | Close it |
| <kbd>Ctrl</kbd> <kbd>`</kbd> | Anywhere | Show or hide the terminal |
| <kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>`</kbd> | Terminal | New terminal tab |
| <kbd>F2</kbd> | Files | Rename |
| <kbd>Delete</kbd> (<kbd>⌘</kbd> <kbd>⌫</kbd> on a Mac) | Files | Move to the Trash, after you confirm |
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>C</kbd>, <kbd>X</kbd>, <kbd>V</kbd> | Files | Copy, cut, paste into the selected folder |
| <kbd>↑</kbd> <kbd>↓</kbd> <kbd>←</kbd> <kbd>→</kbd>, <kbd>Enter</kbd> | Files | Move, open or close a folder, open a file |
| Double-click a session's title | Sidebar | Rename it |
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> + mouse wheel | System map | Zoom |

## Files

**Files** in the top bar shows the repository's files beside the chat. Click a folder to open it, and
a file to read it in the side panel; **Back to Files** returns.

| To | Do this |
|---|---|
| Make a file or folder | **New file** or **New folder** in the toolbar. It goes into the selected folder |
| Rename | Right-click → **Rename**, or select it and press <kbd>F2</kbd> |
| Duplicate | Right-click → **Duplicate**. The copy is called "name copy" |
| Copy or move | Right-click → **Copy** or **Cut**, then right-click a folder → **Paste** (or <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>C</kbd>, <kbd>X</kbd>, <kbd>V</kbd>) |
| Copy a path | Right-click → **Copy path** (full) or **Copy relative path** |
| Delete | Right-click → **Move to Trash**, or <kbd>Delete</kbd> (<kbd>⌘</kbd> <kbd>⌫</kbd> on a Mac), then confirm |
| Open a terminal there | **Terminal** in the toolbar opens one in the selected folder |

By design it will not: work outside the open repository or through a link; show or change Git's own
folder; open or change a file that looks like it holds secrets (shown with a lock); or overwrite
anything. Deleted items go to the Trash (the Recycle Bin on Windows), where you can restore them.
Every change is recorded in the evidence ledger.

## Terminal

**Terminal** in the top bar (or <kbd>Ctrl</kbd> <kbd>`</kbd>) opens a real shell in the open
repository: zsh or bash on macOS and Linux, PowerShell on Windows. It opens in the side panel; the
button in its header docks it under the chat instead, and back. AlbertCode remembers where you put it.

- **Tabs.** **+** (or <kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>`</kbd>) opens another. Close a tab with
  its **×**, a middle-click, or <kbd>Delete</kbd> when the tab is focused.
- **Size.** Drag the side panel's edge; under the chat, drag the panel's top edge, or double-click
  it to maximise.
- **Copy and paste.** Select and press <kbd>Ctrl</kbd> <kbd>C</kbd> (with nothing selected it
  interrupts, as usual), or <kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>C</kbd> and
  <kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>V</kbd>. On a Mac, <kbd>⌘</kbd> <kbd>C</kbd> and
  <kbd>⌘</kbd> <kbd>V</kbd>.
- **It keeps running.** Hide it, move it, or reload the page: each shell carries on and comes back
  with what it wrote. A shell that has ended says so; press <kbd>Enter</kbd> for a new one.

The terminal is off until you turn it on. The first time, the panel explains what it allows: what
you type runs on your computer as you, outside the limits AlbertCode puts on the agent. Only your own
AlbertCode page can connect to it, a shared AlbertCode server never offers it, and no model key is
in its environment. Turning it on or off and opening or closing a shell are recorded in the ledger;
what you type is not. Turn it off from the panel's **⋯** menu, which closes every shell it opened;
**Open in your terminal app** there opens your own terminal instead.

## Preview and Test

**Preview** runs the repository's app beside the chat, and lets you edit it by clicking. **Test**
runs its browser tests. Both have their own guide: [Preview and browser tests](preview-and-tests.md).

## Run app

**Run app** on the repository card is the quickest way to start the app with one command: AlbertCode
fills in the command it found (such as `npm run dev`), or you type one, then **Run**. **Open** opens
the app in a new tab, **Stop** stops it. For an app of several parts (a front end, an API, a worker,
a database), use **Start all** on the [System page](system.md#run-every-part) instead.

## The side panel

Files, links and pictures you open from a chat, a plan, the task board or any page open in the side
panel, beside what you were doing. Its header has **Reload**, **Copy** (the path or address) and
**Close**.

## Documentation

**Documentation**, in the ⋮ menu or the command palette, opens this guide in the side panel: every
page, served by AlbertCode itself, so it works offline. Links between pages open in the panel; links
to the web open in a new tab. **‹ All documentation** goes back to the start. The same pages are
published on the web, in the public repository's `docs/` folder.

## Light, dark and focus

**Light or dark** in the ⋮ menu switches the theme; by default AlbertCode follows your system.
**Focus mode** hides the sidebar for a wider conversation; the **☰** button brings it back.
