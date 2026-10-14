# Browser interface

The browser workspace puts the conversation, Albert's steps, the plan and the diff, the app and its tests, the
repository's files and a terminal side by side. Start it from a terminal:

```bash
cd your-project
albertcode web
```

`albertcode --ui` does the same. It opens in your default browser, signed in, on the folder you started it in. To
make `albertcode` always open the browser, set `ALBERTCODE_SURFACE=ui`. Each session has an address of its own,
ending in `/s/` and the session's id, so a bookmark or a reload opens it again.

The browser and the [terminal interface](terminal.md#the-terminal-interface) work on the same sessions: a session
started in one is there in the other, and what Albert does shows in both as it happens. If a page ever asks you to
open AlbertCode from your terminal, run `albertcode web` again: a new version of AlbertCode signs in again.

## The workspace

```text
┌ AlbertCode   Session  Project  Git  Evidence  View  Settings  Help ─────────────────────────────────┐
│ SESSIONS     ‹ │ Show prices in euros   shop ⎇ main · Governed              │ Changes Files App Tests │
│ ✎ New session  │                                                              │ Context Task            │
│ ⌕ Find a sess… │  You     Show the prices in euros                            │                         │
│ ▾ S shop     3 │  Albert  ▸ 3 steps before answering                          │ The inspector: the      │
│   ● Show pri…  │  ┌ Task · Plan waiting for you ─────────────────────────┐   │ change, the files, the  │
│   ○ Fix the c… │  │ ✓ Read the project  ◆ Plan ready  ○ Build  ○ Checks  │   │ app, its tests, the     │
│ ▸ N notes    2 │  └ Approve and build · Revise · Reject ─────────────────┘   │ context, the task       │
│                │  ❯ Ask anything, or say what to change    Governed · model   │                         │
│                ├ Terminal (Ctrl+`) ───────────────────────────────────────────┤                         │
└ ● Live · shop · main ──────────────────────────── Governed · model · MCP 1/1 · Inspector ───────────┘
```

- **The menu bar** at the top: every command, by area. See [The menus](#the-menus).
- **Sessions**, down the left: every project with its sessions under it, each with a lamp that says whether it
  is working (it moves), waiting for you (amber) or stopped with an error (red). **New session** starts one in
  the project you are in; **Find a session** searches titles and what was said. Each session's **⋯** has
  **Rename**, **Pin**, **Stop**, **Archive** and **Delete**, and **‹** folds the list to a rail of its projects.
- **The conversation**: your messages, Albert's answers, and each task as a card with Albert's steps as he takes
  them, what he read, wrote and ran, a stage at a time, and the answers its gate takes when it needs you. See
  [While Albert works](chat.md#while-albert-works).
- **The message box** at the bottom: the mode (**Governed**; **Direct**, with **Ask each write** or
  **Auto-approve**; or **Ask only**), the model, the agent, and **+** to attach files. Type `/` for
  [slash commands](#slash-commands).
- **The inspector** on the right (<kbd>Alt</kbd> <kbd>P</kbd>): the change, the repository's files, the app, its
  browser tests, the context and the task in full. See [The inspector](#the-inspector).
- **The terminal**, under the conversation (<kbd>Ctrl</kbd> <kbd>`</kbd>). See [Terminal](#terminal).
- **The status bar**: whether the service is live, the folder and its branch, the mode, the model, the MCP
  servers connected, and a button for the inspector.

**Every session** (<kbd>Alt</kbd> <kbd>B</kbd>) shows every session as cards by day, searched across titles and
what was said, with the projects on the left. On a narrow window the sessions and the inspector fold away and
come back from the buttons at the top.

## The menus

### Session

| Item | What it does |
|---|---|
| **New session** (<kbd>Alt</kbd> <kbd>N</kbd>) | A fresh conversation in this project. Sessions at work carry on |
| **Every session** (<kbd>Alt</kbd> <kbd>B</kbd>) | Every session as cards by day, to search and open |
| **Rename…**, **Pin** or **Unpin** | Name the session; keep it at the top of its project |
| **Fork** | A new session holding this one's messages, to try another way |
| **Export…**, **Import…** | Save the session as a JSON file; open one saved that way |
| **Archive** or **Unarchive** | Take it off the list, or bring it back |
| **Stop** (<kbd>Esc</kbd>) | Stop what Albert is doing in this session |
| **Delete…** | Its messages go; its tasks and their evidence stay |

### Project

| Item | What it does |
|---|---|
| **Open a folder…** | Choose the repository new sessions work in |
| **Clone a repository…** | Clone one from its address (GitHub, GitLab …) and open it |
| **Recent** | The folders you used last |
| **Worktrees…** | Another checkout of the repository on a branch of its own |
| **Run the app** | Start the app and show it in the inspector. See [Preview and browser tests](preview-and-tests.md) |
| **Browser tests** | The inspector's **Tests** tab |
| **Files** | The inspector's **Files** tab |
| **Terminal** or **Hide the terminal** (<kbd>Ctrl</kbd> <kbd>`</kbd>) | A shell in the repository, under the conversation |
| **Architecture…** | What the repository is made of. See [Architecture](architecture.md) |

### Git

| Item | What it does |
|---|---|
| **Changes** | The working tree's changes, in the inspector |
| **Commit…** | Commit them, with a message you write or one Albert suggests |
| **Pull**, **Push** | Bring in the branch's upstream (fast-forward only); push the branch |
| **Switch branch…**, **New branch…**, **New worktree…** | Move between branches, or start one |
| **Set up Git here** | A folder without Git gets a repository, on branch `main` |

### Evidence

| Item | What it does |
|---|---|
| **Tasks…** | Every task by where it stands. See [The task board](tasks-and-evidence.md#the-task-board) |
| **Evidence ledger…** | Every governed action, chained. See [The evidence ledger](tasks-and-evidence.md#the-evidence-ledger) |
| **Requirements…** | What the app must do, and what proves it. See [Requirements](requirements.md) |
| **Contract and memory…** | The boundary every task works within, and what Albert has learned here. See [The contract](contract.md) |

### View

| Item | What it does |
|---|---|
| **Changes**, **Files**, **App**, **Tests**, **Context**, **Task** | Open that tab of the inspector |
| **Show the inspector** or **Hide the inspector** (<kbd>Alt</kbd> <kbd>P</kbd>) | |
| **Show the agent's steps** (<kbd>Alt</kbd> <kbd>S</kbd>) | Every step of every task in the conversation, or each task folded to its card |
| **Theme** | **Match the system**, or **Nebula (dark)**, **Aurora (light)**, **Ember (dark)**, **Ember light**, **Slate (dark)** or **High contrast** |
| **Show the time of each message** | |

### Settings

| Item | What it does |
|---|---|
| **Settings…** | **General**, **Providers**, **Models**, **MCP servers**, **Agents**, **Keys** and **About** |
| **Providers…**, **Connect a provider…** | Connect a model provider. See [Models](models.md) |
| **Models…** (<kbd>Alt</kbd> <kbd>M</kbd>) | The model for this session |
| **MCP servers…** | Your servers, the connectors to add, and what they offer. See [MCP servers](mcp.md) |
| **Agents…** | Work as one of your custom agents |
| **Language checks…** | Which languages each edit is checked in. See [Language checks](tasks-and-evidence.md#language-checks) |
| **Tools and skills…** | What this repository runs with. See [Tools and skills](extending.md#tools-and-skills) |
| **Commands, agents and plugins…** | Make, use and delete them. See [Extending](extending.md) and [Plugins](plugins.md) |
| **Sign out of this service** | On an AlbertCode service your organisation runs: forget its key in this browser |

### Help

| Item | What it does |
|---|---|
| **Every command** (<kbd>Ctrl</kbd> <kbd>K</kbd>) | [The command palette](#the-command-palette) |
| **Search the guide…**, **Keys and commands** | This guide, inside AlbertCode, searched as you type; it works offline |
| **The guide online** | The same pages on the web |
| **Service status** | The service, the engine, the model and what is connected |
| **The classic page** | The page AlbertCode had before this workspace. See [The classic page](#the-classic-page) |

## The inspector

The inspector, on the right, holds what goes with the conversation. <kbd>Alt</kbd> <kbd>P</kbd> shows or hides it;
on a narrow window it opens over the conversation.

### Changes

The working tree's changes, file by file with their diffs, and the branch. A governed task's change stays in its
own copy until you accept it, so it shows on its card, not here, until then.

### Files

The repository's files, as a tree. Click a folder to open it and a file to read it, with line numbers; **Files**
goes back to the tree. A file named in an answer opens here (see [below](#a-file-named-in-an-answer)).

| To | Do this |
|---|---|
| Make a file or folder | **New file** or **New folder**, type its name, <kbd>Enter</kbd>. It goes into the selected folder |
| Rename | **⋯** → **Rename**, or select it and press <kbd>F2</kbd> |
| Duplicate | **⋯** → **Duplicate**. The copy is called "name copy" |
| Copy or move | **⋯** → **Copy** or **Cut**, then a folder's **⋯** → **Paste** (or <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>C</kbd>, <kbd>X</kbd>, <kbd>V</kbd>) |
| Copy a path | **⋯** → **Copy path** (full) or **Copy relative path** |
| Delete | **⋯** → **Move to Trash**, or <kbd>Delete</kbd> (<kbd>⌘</kbd> <kbd>⌫</kbd> on a Mac), then **Move to Trash** again to confirm |
| Open a terminal there | **⋯** → **Open a terminal here**, or **Terminal** in the toolbar for the selected folder |

The arrows move through the tree; <kbd>→</kbd> opens a folder, <kbd>←</kbd> closes it, <kbd>Enter</kbd> opens a
file. By design it will not work outside the repository or through a link, show or change Git's own folder, open or
change a file that looks like it holds secrets (shown with a lock), or overwrite anything. Deleted items go to the
Trash (the Recycle Bin on Windows), where you can restore them, and every change is recorded in the evidence ledger.

### App

**Run the app** (or `/preview`) starts the repository's app with its dev script and shows it here, at desktop,
tablet or phone width. The toolbar has **Edit** (change the page by clicking it), **Logs**, **Reload**, **Open in
browser**, **Restart** and **Stop the app**. When the app fails or answers with an error, **Ask Albert to fix**
puts what went wrong in the message box, to read and send. See [Preview and browser tests](preview-and-tests.md).

### Tests

The repository's browser tests, a step at a time: Albert writes them (as a task, so you approve the plan and the
diff), the test runner is installed, a browser is found or downloaded, then **Run tests** checks every journey
against the app. A failed test shows its error and screenshot, with **Fix with Albert** (a session of its own, given
the error and how to run the test), **Open the test**, **Download trace** and **Run again**. See
[Preview and browser tests](preview-and-tests.md).

### Context and Task

**Context** shows what this session's tasks used: tokens, the context each step had, and the cost when the
provider gives one. **Task** shows the open task in full: its plan, every stage and step, its checks and reviews.

## Terminal

**Terminal** in the **Project** menu (or <kbd>Ctrl</kbd> <kbd>`</kbd>) opens a real shell in the repository, under
the conversation: zsh or bash on macOS and Linux, PowerShell on Windows.

- **Turn it on first.** The first time, the panel says what it allows: what you type runs on your computer as
  you, outside the limits AlbertCode puts on the agent. **Turn on the terminal** turns it on; **Use my terminal
  app instead** opens your own terminal in the repository.
- **Tabs.** **New terminal** (or <kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>`</kbd>) opens another; each tab's **×**
  closes it.
- **Size.** Drag the line at its top. AlbertCode remembers the height.
- **It keeps running.** Hide it or reload the page: each shell carries on and comes back with what it wrote. A
  shell that has ended says so.

Only your own AlbertCode page can connect to it, a shared AlbertCode server never offers it, and no model key is
in its environment. Turning it on or off and opening or closing a shell are recorded in the ledger; what you type
is not. The **⋯** menu has **Open my terminal app here** and **Turn the terminal off**, which closes every shell
it opened.

## The command palette

<kbd>Ctrl</kbd> <kbd>K</kbd> (<kbd>⌘</kbd> <kbd>K</kbd> on a Mac), or **Every command** in the **Help** menu,
opens the palette: type to find a command, <kbd>Enter</kbd> to run it.

| Area | Commands |
|---|---|
| Session | **New session**, **Rename this session**, **Fork this session**, **Export this session as JSON**, **Pin this session**, **Stop what Albert is doing**, **Import a session from JSON** |
| View | **Every session**, **Changes**, **Context and usage**, **The task in full**, **Show or hide the agent's steps** |
| Evidence | **Tasks: where each one stands**, **Evidence ledger**, **Requirements and what proves them**, **Contract and memory** |
| Project | **Architecture of this repository**, **Run the app and show it**, **Browser tests**, **Files of this repository**, **Terminal: show or hide** |
| Configure | **Choose the model**, **Connect a provider**, **Work as a custom agent**, **MCP servers**, **Choose the repository for new sessions**, **Language checks after each edit**, **Tools and skills**, **Commands, agents and plugins**, **Settings**, **Theme: match the system** and each other **Theme** |
| Help | **Help: search the guide, keys and commands**, **Service status** |
| Commands | Each of your custom commands, by name: it is put in the message box |

## Slash commands

Typed at the start of the message box. <kbd>Enter</kbd> picks the highlighted one from the list; a command that
needs words after it waits for them, and <kbd>Enter</kbd> again runs it.

| Command | What it does | Example |
|---|---|---|
| `/plan <request>` | A governed change: a plan for your approval first | `/plan Add rate limiting to the login endpoint` |
| `/do <request>` | Change your files directly, asking before each write | `/do Fix the typo in README.md` |
| `/direct auto <request>` | Change your files directly, writes applied as they come | `/direct auto Rename getUser to fetchUser` |
| `/new` | Start a new session | |
| `/model`, `/mode` | The model for this session; the mode: governed, direct, auto or ask | `/mode ask` |
| `/agent <name>` | Work as one of this repository's custom agents | `/agent tester` |
| `/connect` | Connect a model provider | |
| `/mcp` | MCP servers: on or off, sign in, add a connector, import from JSON | |
| `/diff` | This session's change, or your working tree's | |
| `/stop` | Stop what Albert is doing in this session | |
| `/rename`, `/fork` | Rename this session; a new session holding its messages | `/rename Euro prices` |
| `/export`, `/import` | Save this session as JSON; open one saved that way | |
| `/attach` | Attach files to your next message | |
| `/open`, `/clone` | Open a project folder; clone a repository from its address | `/clone https://github.com/you/shop` |
| `/commit`, `/branch`, `/worktree`, `/pull`, `/push` | Git, as in the **Git** menu | `/branch feature/euros` |
| `/tasks` | Every task: where it stands, what it needs | |
| `/ledger` | The evidence ledger | |
| `/contract` | The contract here, and what Albert has learned | |
| `/requirements` | What the app must do, and what proves it | |
| `/architecture` | What this repository is made of, read from its files | |
| `/checks` | Which languages each edit is checked in; install the rest | |
| `/tools` | The tools and skills this repository runs with | |
| `/commands`, `/agents`, `/plugins` | Your custom commands, agents and plugins | |
| `/preview` | Run this repository's app and show it beside the session | |
| `/test` | Browser tests: write them, install the runner, run them | |
| `/files [path[:line]]` | The repository's files; with a path, that file, at that line | `/files src/cart.py:12` |
| `/terminal` | A shell in the repository, under the session | |
| `/theme`, `/settings` | Colours; theme, timestamps and keys | `/theme` |
| `/status` | The service, the engine and what is connected | |
| `/help`, `/docs` | Search the guide, keys and commands | `/docs browser tests` |

A repository can have commands of its own (see [Extending](extending.md)): `/name …` runs one, and
`/server:prompt …` uses an MCP server's prompt. A repository's own `/requirements`, `/architecture`, `/files` or
`/terminal` takes the place of AlbertCode's, since those names are not reserved.

## Keyboard shortcuts

| Keys | What they do |
|---|---|
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>K</kbd> | The command palette |
| <kbd>Alt</kbd> <kbd>N</kbd> | New session |
| <kbd>Alt</kbd> <kbd>B</kbd> | Every session |
| <kbd>Alt</kbd> <kbd>P</kbd> | Show or hide the inspector |
| <kbd>Alt</kbd> <kbd>M</kbd> | Choose the model |
| <kbd>Alt</kbd> <kbd>S</kbd> | Show or hide the agent's steps |
| <kbd>Ctrl</kbd> <kbd>`</kbd> | Show or hide the terminal |
| <kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>`</kbd> | Another terminal |
| <kbd>/</kbd> | Go to the message box |
| <kbd>Enter</kbd>, <kbd>Shift</kbd> <kbd>Enter</kbd> | Send; a new line |
| <kbd>Esc</kbd> | Close a dialog; leave **Every session**; stop what Albert is doing |
| <kbd>F2</kbd>, <kbd>Delete</kbd> | In **Files**: rename; move to the Trash, after you confirm |

**Keys and commands** in the **Help** menu lists them all.

## A file named in an answer

When Albert names a file in an answer, such as `src/cart.py` or `src/cart.py:12`, the name is a link: click it
(or press <kbd>Enter</kbd> on it) and the file opens in the inspector's **Files** tab, at that line. Code in an
answer is always shown as text, never run in the page.

## The classic page

The page AlbertCode had before this workspace is still served, at `/ui` on the same service (**The classic page**
in the **Help** menu), while every screen finishes moving over. It works on the same tasks, evidence and settings.
The rest of this page describes it.

### The classic layout


```text
┌ Sidebar ──────────────┬ Top bar: session title · folder · Preview · Test · Files · Terminal · ⋮ ─────┐
│ AlbertCode  v1.51  ◧  │ ✓ Plan ─ ◆ Your approval ─ ○ Build in a copy ─ ○ Checks ─ … ─ ○ In your files│
│ ┌ repository ───────┐ │                                                                              │
│ │ S shop     Browse │ │   The page: Chat, or Requirements, Architecture, Tasks…                      │
│ │ Boundary · Run app│ │                                                   ┌ Side panel ──────────┐   │
│ └───────────────────┘ │                                                   │ Preview, Test,       │   │
│ ● New session         │                                                   │ Files, Terminal or   │   │
│ Search sessions       │                                                   │ a file               │   │
│ SESSIONS Projects|Days│                                                   └──────────────────────┘   │
│ ▾ S shop           3  │                                                                              │
│    ● Show prices…     │                                                                              │
│    ○ Fix the cart  1h │                                                                              │
│ ▸ N notes          2  │   ┌ message box · mode · model · attach ─────────────────────────────────┐   │
└───────────────────────┴───┴──────────────────────────────────────────────────────────────────────┴───┘
```

- **The repository card** at the top of the sidebar: the folder you are working in, with
  **Browse** to choose another, **Boundary** for its [contract](contract.md), and **Run app** to
  start its app with one command.
- **New session** and **Search sessions**, then every session **under the folder it works in**, the
  folder you used most recently first, each with a lamp that says whether its run is working or
  waiting for you. **Days** lists them by day instead. See [Sessions](chat.md#sessions) and
  [Chats about one thing](chat.md#chats-about-one-thing).
- **◧**, at the top right of the sidebar, folds it to a rail (see
  [Folding the sidebar](#folding-the-sidebar)).
- **The top bar**: on Chat, the session's own title (click it to rename the session) and its folder;
  on any other page, that page's name. Then the side panels (**Preview**, **Test**, **Files**,
  **Terminal**), and the **⋮** menu with every other page and setting.
- **The gate track**, under the top bar while the session has a governed task: where the task
  stands, from the plan to your files. See [While Albert works](chat.md#while-albert-works).
- **The message box** at the bottom of Chat, with the mode chip, the model chip, the agent chip and
  the attach button.

On a narrow window the sidebar folds away behind the **☰** button at the top left.

#### Folding the sidebar

**◧** at the top right of the sidebar, or **Fold the sidebar** in the command palette, folds the
sidebar to a rail of icons so the conversation gets the room. The rail keeps:

| On the rail | What it does |
|---|---|
| ◧ | Opens the sidebar again (**Show the sidebar** in the palette does too) |
| **+** | A new session |
| The magnifier | Opens the sidebar and puts you in **Search sessions** |
| Each folder's mark | Opens a session there: the one waiting for you, else the one at work, else the newest. A dot on the mark says one of its sessions is working (it moves), waiting for you (amber) or stopped with an error (red) |

AlbertCode remembers whether the sidebar is folded. **Focus mode** hides it altogether.

### Choosing a folder

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

### The ⋮ menu

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

A dot on the **⋮** button means a task is waiting for you.

### The classic command palette

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
| Open architecture | **Architecture** |
| Open evidence ledger | **Evidence ledger** |
| Open the contract | **Contract** |
| Models and keys (advanced) | **Models and keys** |
| Light or dark | |
| Focus mode | |
| List sessions by day, List sessions by project | **Projects** and **Days** above the sessions |
| Fold the sidebar, Show the sidebar | **◧** at the top right of the sidebar |
| Documentation — every command, page and button, with examples | **Documentation** |

Below the commands, the palette lists your sessions, each with its folder and day: pick one to open it.
Typing a folder's name finds its sessions.

### Slash commands on the classic page

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

### Keys on the classic page

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
| Click the session's title | Top bar, on Chat | Rename it: <kbd>Enter</kbd> keeps the new name, <kbd>Esc</kbd> puts the old one back |

### Files on the classic page

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

### The terminal on the classic page

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

### Preview and Test on the classic page

**Preview** runs the repository's app beside the chat, and lets you edit it by clicking. **Test**
runs its browser tests. Both have their own guide: [Preview and browser tests](preview-and-tests.md).

### Run app

**Run app** on the repository card is the quickest way to start the app with one command: AlbertCode
fills in the command it found (such as `npm run dev`), or you type one, then **Run**. **Open** opens
the app in a new tab, **Stop** stops it.

### The side panel

Files, links and pictures you open from a chat, a plan, the task board or any page open in the side
panel, beside what you were doing. Its header has **Reload**, **Copy** (the path or address) and
**Close**.

### Documentation

**Documentation**, in the ⋮ menu or the command palette, opens this guide in the side panel: every
page, served by AlbertCode itself, so it works offline. Links between pages open in the panel; links
to the web open in a new tab. **‹ All documentation** goes back to the start. The same pages are
published on the web, in the public repository's `docs/` folder.

### Light, dark and focus

**Light or dark** in the ⋮ menu switches the theme; by default AlbertCode follows your system.
**Focus mode** hides the sidebar for a wider conversation; the **☰** button brings it back. To keep
your sessions in reach with the same room, [fold the sidebar](#folding-the-sidebar) instead.
