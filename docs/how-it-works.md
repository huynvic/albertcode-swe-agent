# How AlbertCode works

This page explains the pieces you meet in every part of AlbertCode, and how they fit together. The
other guides assume you know them.

## One service, three ways in

AlbertCode runs as a small **service on your own computer**. You talk to it through any of three
interfaces, and they all see the same tasks, sessions and settings:

| Interface | Start it | Read |
|---|---|---|
| **Terminal** | `albertcode` in a project folder | [Terminal](terminal.md) |
| **Browser** | `albertcode --ui` | [Browser interface](browser.md) |
| **VS Code** | the AlbertCode panel in the activity bar | [VS Code](vscode.md) |

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
  what to change and does it, the way the current **mode** says.

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

## Tasks, sessions and topics

- A **task** is one change: its request, plan, build, checks, reviews and diff. Tasks are listed on
  the [task board](tasks-and-evidence.md#the-task-board) and with `/tasks`.
- A **session** (or chat) is one conversation. It can hold several questions and several tasks; a
  follow-up such as "now add a test for the empty case" continues the task before it. **New
  session** starts a fresh conversation; nothing said in one session reaches another.
- A **topic** groups the sessions started about one thing. Building a slice of your app, repairing
  it twice and rolling it back are four sessions about one slice: the browser's sidebar shows them
  as one row that opens to all four. See [Chats about one thing](chat.md#chats-about-one-thing).

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
| Data folder: `~/Library/Application Support/AlbertCode SWE Agent` (macOS), `~/.local/share/AlbertCode SWE Agent` (Linux), `%LOCALAPPDATA%\AlbertCode SWE Agent` (Windows) | Task history, isolated copies, the evidence ledger, System maps, the service's log (`backend.log`) |
| Settings folder: `~/Library/Application Support/AlbertCode SWE Agent` (macOS), `~/.config/AlbertCode SWE Agent` (Linux), `%APPDATA%\AlbertCode SWE Agent` (Windows) | Your settings, personal commands and agents, installed plugins |
| Your system's key store: the macOS Keychain, Windows data protection or your Linux keyring | Provider keys, MCP sign-ins and the keys of services you connect on the System page |

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
| [System](system.md) | Design the app on a map, connect its services, have Albert build it slice by slice, run every part, fix problems and release |
| [Preview and browser tests](preview-and-tests.md) | Run the app beside the chat, edit it by clicking, and test it in a browser |
