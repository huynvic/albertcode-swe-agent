# How AlbertCode works

This page explains the pieces you meet in every part of AlbertCode, and how they fit together. The
other guides assume you know them.

## One service, many ways in

AlbertCode runs as a small **service on your own computer**. You talk to it through any of these, and
they all see the same tasks, sessions and settings:

| Interface | Start it | Read |
|---|---|---|
| **Terminal** | `albertcode` in a project folder | [Terminal](terminal.md) |
| **Browser** | `albertcode --ui` | [Browser interface](browser.md) |
| **VS Code** | the AlbertCode panel in the activity bar | [VS Code](vscode.md) |
| **Other editors** | Cursor, Windsurf and VSCodium with the same extension; Zed, JetBrains IDEs, Neovim, Emacs and others with `albertcode acp` | [Other editors](editors.md) |

The first command you run starts the service in the background. It keeps running between sessions,
so a task started in the browser can be followed in the terminal, and a run keeps going when you
close a window. `albertcode stop` stops it, and the next `albertcode` starts it again.

Only AlbertCode itself can use the service. Each installation has its own access token, in a file
only you can read: the terminal and the VS Code extension send it for you, and `albertcode --ui`
signs your browser in. Other programs and web pages on your computer are refused. See the
[security model](security.md).

## Asking and changing

Everything you type is one of two things:

- **A question.** "Where is the login handled?" Albert reads the repository and answers. Nothing is
  changed.
- **A change.** "Make the login endpoint return 400 when the password is empty." Albert works out
  what to change and does it, the way the current **mode** says. In Governed and Direct it says in one
  sentence what it is about to do and starts at once, without reading the repository first: the work
  reads what it needs, so reading before it would only make you wait twice.

Albert tells the two apart from your words. To decide for it, start a request with `/plan` (a
governed change) or `/do` (a direct change). See [Chatting with Albert](chat.md).

## Modes

| Mode | What a change does | Use it for |
|---|---|---|
| **Governed** (default) | Starts with a plan for your approval. It is built in an isolated copy, tested and reviewed, and reaches your files only when you accept the diff | Changes you care about |
| **Direct, ask each write** | Works in your real files and asks before each write | Small changes you are watching |
| **Direct, auto** | Works in your real files; writes apply as they come | Quick work in a repository you can undo with Git |
| **Ask only** | Answers questions; a change is offered, never started | Learning a codebase |

Direct needs the folder to be a Git repository, because Git is how you undo a direct change.

Switch modes with `/mode` in the terminal, the mode chip under the message box in the browser, or the
**Governed**, **Direct** and **Ask only** buttons above the message box in VS Code. The mode applies
to plain requests; `/plan` and `/do` choose for one request.

## The life of a governed change

```text
 Plan ─▶ ① you approve the plan ─▶ Build ─▶ Verify ─▶ Review ─▶ ② you accept the diff ─▶ Applied
```

1. **Plan.** Albert reads the repository and writes a plan: the goal, the files it expects to change
   and how, the steps, how it will test the change, the risk, and how to undo it. Nothing is
   written yet.
2. **Approval 1: the plan.** You approve it, or reject it and say what you want instead. Rejecting
   discards the task.
3. **Build.** Albert makes the change in an **isolated copy** of your repository, never in your
   working tree. After each edit, the file is checked by its language's own checker where one is
   installed ([language checks](tasks-and-evidence.md#language-checks)), and Albert fixes what its
   edit broke straight away.
4. **Verify.** Your project's own tests and checks run in the copy: `pytest`, your npm scripts,
   `go test`, `cargo test`, Maven, Gradle, `dotnet test` and so on. `albertcode doctor` shows which
   of these tools AlbertCode can find.
5. **Review.** At the *thorough* pace (the default), the change gets an independent security review
   and an independent quality review. At the *fast* pace these are skipped. See
   [Pace](models.md#pace).
6. **Approval 2: the diff.** You see the diff, what passed and what failed, and the reviews. Accept
   it, discard it, or ask for changes in the same chat.
7. **Applied.** Accepting copies the change into your files. If you edited a file the change also
   touches while Albert worked, acceptance is refused rather than overwriting your work: look at
   your edit, then run the task again.

Accepted changes are ordinary edits in your working tree. Review them with `git diff`, commit them,
and undo them with Git. A task you have not accepted can be thrown away with **Discard** in the
browser, or `albertcode rollback <task>`, which deletes its isolated copy.

## Several agents on one task

Albert is the agent you talk to, but one task can use several. AlbertCode starts other agents for it
in three places, each with less authority than Albert has, and every step they take is recorded on
the task like Albert's own.

**Questions answered in parallel.** When Albert needs several things found out before it can start
(where something is handled, what calls a module, how this project does a thing), it can ask up to
four questions at once. Each question goes to an agent of its own, and they work at the same time.
Each answer is a short reply naming the files and lines that show it. These agents can only read:
they cannot change anything, and they cannot start agents of their own. A question one of them
cannot answer comes back saying so, and the task carries on. Albert can ask them while it plans a
governed change, while it builds one, and in Direct.

**Work split between agents.** A change made of independent parts can be split into up to six work
items. Each names what it is for, the exact files it may change and what it depends on; items that
touch the same files, or share an interface, are never built at the same time. Albert hands each
item to an agent of its own, two at a time, in the order the dependencies allow:

- Each agent works in a disposable copy of its own and may change only its item's files, within what
  the [contract](contract.md) allows. An item that changes any other file, or deletes one, fails.
- When an item fails, the items that depend on it are not started and nothing is changed.
- When every item is done, their work is put together and a test run of your project checks the
  whole. Only if it passes is the change written, the same way as any other edit: into the isolated
  copy in Governed, where it is still verified and reviewed and waits for your approval, or into
  your files in Direct, asking before each write when Direct asks.
- An agent cannot pass its item on to more agents, and a task can split its work this way at most
  three times.

While this happens the activity reads **Organizing work by its dependencies** and **Coordinating
isolated implementation work**, and the evidence names the work item behind each step.

**Two reviews at once.** At the *thorough* pace, the security review and the quality review each
read the finished change in a fresh conversation of their own that cannot change anything, and the
two run at the same time. A small, low-risk change gets one reading that covers both.

## Tasks, sessions and topics

- A **task** is one change: its request, plan, build, checks, reviews and diff. Tasks are listed on
  the [task board](tasks-and-evidence.md#the-task-board) and with `/tasks`.
- A **session** (or chat) is one conversation. It can hold several questions and several tasks; a
  follow-up such as "now add a test for the empty case" continues the task before it. **New
  session** starts a fresh conversation; nothing said in one session reaches another.
- A **topic** groups the sessions started about one thing. Building a requirement, adding a test for
  it and fixing it are three sessions about one requirement: the browser's sidebar shows them as one
  row that opens to all three. See [Chats about one thing](chat.md#chats-about-one-thing).

Runs belong to the service, not the window. Starting a new session, opening another one or closing
the page never stops a run; its session in the sidebar shows when it is working or waiting for you.

## The evidence

Every task keeps a record of what happened: the plan you approved, every command it ran and its
result, every check and review, the diff, and who approved what and when. The **evidence ledger**
holds these records in order, each linked to the one before it, so a changed or deleted entry is
detected. Read it with `/ledger` or **Evidence ledger** in the browser, and export one change's
evidence for an auditor with `albertcode compliance <task>`. See
[Tasks and evidence](tasks-and-evidence.md).

## The boundary: your repository's contract

A repository can carry a **contract**, `albertcode.contract.toml` at its root, that limits what
AlbertCode may do there: which paths may change and how much, which commands may run, which checks
must pass, which reviews are required and who may approve. With no contract, sensible defaults
apply. The contract is read from your repository, never from Albert's copy, so a task cannot widen
its own limits. See [The contract](contract.md).

## What AlbertCode keeps, and where

**In your repository** (yours to read, edit and commit):

| Path | What it is |
|---|---|
| `albertcode.contract.toml` | The contract, if you write one |
| `.albertcode/requirements.json` | Your [requirements](requirements.md) |
| `.albertcode/memory.md` | What Albert has learned about this repository |
| `.albertcode/commands/`, `.albertcode/agents/`, `.albertcode/skills/` | Custom [commands, agents and skills](extending.md) |
| `e2e/` | Browser tests, when you have Albert write them |

**On your computer, outside the repository** (private to your user account):

| Folder | Holds |
|---|---|
| Data folder: `~/Library/Application Support/AlbertCode SWE Agent` (macOS), `~/.local/share/AlbertCode SWE Agent` (Linux), `%LOCALAPPDATA%\AlbertCode SWE Agent` (Windows) | Task history, isolated copies, the evidence ledger, the service's log (`backend.log`) |
| Settings folder: `~/Library/Application Support/AlbertCode SWE Agent` (macOS), `~/.config/AlbertCode SWE Agent` (Linux), `%APPDATA%\AlbertCode SWE Agent` (Windows) | Your settings, personal commands and agents, installed plugins |
| Your system's key store: the macOS Keychain, Windows data protection or your Linux keyring | Provider keys and MCP sign-ins |

`/cleanup` shows how much space the isolated copies use and clears them. `albertcode uninstall
--all` removes everything AlbertCode keeps outside your repositories.

## What the model sees

To work on your code, AlbertCode sends your chosen model the parts of the repository a task needs,
and your messages. Keys are never sent: provider keys go only to their own provider, and anything
that looks like a secret is masked before a model sees it. Files that look like they hold secrets,
such as `.env` and private keys, are never read. With a local model, nothing leaves your computer.
See [Models](models.md) and the [security model](security.md).

## The pages for building whole systems

Beyond single changes, the browser has pages for the whole app:

| Page | What it does |
|---|---|
| [Requirements](requirements.md) | What the app must do, as a checklist with evidence |
| [Architecture](architecture.md) | What the repository is made of, read from its files |
| [Preview and browser tests](preview-and-tests.md) | Run the app beside the chat, edit it by clicking, and test it in a browser |
