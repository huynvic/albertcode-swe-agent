# Using AlbertCode

## Three interfaces, one agent

| Interface | Start it | Good for |
|---|---|---|
| Terminal | `albertcode` | Working where you already are |
| Browser | `albertcode --ui` | Reading plans and diffs side by side; several sessions at once |
| VS Code | the AlbertCode panel | Staying in the editor; right-click a folder → *Open Here* |

All three talk to the same local service, so a task started in one can be followed in another.

## Modes

| Mode | What happens | Use it when |
|---|---|---|
| **Governed** (default) | You approve a plan, it works in an isolated copy, runs your tests and reviews the result, then you approve the diff | Changes you care about |
| **Direct** | It works in your real files and asks before each write (or, with `auto`, doesn't ask). Needs Git. | Pairing on something you're watching |
| **Ask** | It answers questions and changes nothing | Understanding a codebase |

Switch with `/mode`, or start one request in a given mode with `/plan` or `/do`.

## Files panel

In the browser interface, **Files** in the top bar shows the open repository's files beside the
chat. Click a folder to open it, and a file to read it in the viewer; **Back to Files** returns.

| To | Do this |
|---|---|
| Make a file or folder | **New file** or **New folder** in the toolbar. It goes into the selected folder |
| Rename | Right-click → **Rename**, or select it and press F2 |
| Duplicate | Right-click → **Duplicate**. The copy is called "name copy" |
| Copy or move | Right-click → **Copy** or **Cut**, then right-click a folder → **Paste** (or Ctrl/⌘ C, X and V) |
| Copy a path | Right-click → **Copy path** (full) or **Copy relative path** |
| Delete | Right-click → **Move to Trash**, or Delete (⌘⌫ on a Mac), then confirm |

What it will not do, by design: work outside the open repository or through a link; show or change
Git's own folder; open or change a file that looks like it holds secrets (shown with a lock);
overwrite anything. Deleted items go to the Trash (the Recycle Bin on Windows), where you can restore
them. The panel is offered only on your own computer, and every change is recorded in AlbertCode's
ledger.

## Terminal

In the browser interface, **Terminal** in the top bar (or Ctrl+`) opens a real shell in the open
repository: zsh or bash on macOS and Linux, PowerShell on Windows. It opens beside the chat, in the
side panel like Files; the button in its header docks it under the chat instead, and back, and
AlbertCode remembers where you put it. Run your project's tests, builds and other checks here.

- **Tabs.** **+** (or Ctrl+Shift+`) opens another; **Terminal** in the Files panel opens one in the
  selected folder. Close a tab with its ×, a middle-click, or Delete when the tab is focused.
- **Size.** Beside the chat, drag the side panel's edge. Under the chat, drag the panel's top edge,
  or double-click it (or use the arrow button) to maximise.
- **Copy and paste.** Select to copy with Ctrl+C (Ctrl+C with nothing selected interrupts, as
  usual), or Ctrl+Shift+C and Ctrl+Shift+V. On a Mac, ⌘C and ⌘V.
- **It keeps running.** Hide it, move it, open a file in the side panel, or reload the page: each
  shell carries on and comes back with what it wrote. A shell that has ended says so; press Enter to start a new one.

The first time, the panel explains what it allows and asks you to turn it on: what you type runs
on this computer as you, and the limits AlbertCode puts on the agent's commands do not apply to it.
Only your own AlbertCode page can connect, a shared AlbertCode server never offers it, and no
model key is in its environment. Turning it on or off and opening or closing a shell are recorded
in the ledger; what you type is not. Turn it off from the panel's ⋯ menu, which closes every shell
it opened; **Open in your terminal app** there opens your own terminal instead.

## Preview

**Preview** in the browser's top bar starts the open repository's app if it is not running and
shows it in the side panel. It uses the project's dev script; when there is none, it asks for the
start command once and remembers it.

- **Widths.** Desktop, tablet (834 px) and phone (390 px).
- **Status.** Whether the app is answering, on which address, with which status and how fast.
- **Problems, said plainly.** It did not start, it stopped, it answers with an error page, or its
  output reports an error now. An error that has since been fixed is not shown as current.
  **Ask Albert to fix** puts the error into the chat; **Logs** shows the app's output.
- **Restart** and **Stop** are in the panel's header.

### Edit by clicking

**Edit** in the Preview panel lets you change the app by clicking it.

1. Turn on **Edit**. Hovering outlines what you would choose; links and buttons do not act while
   editing. Click to choose; Esc lets go.
2. Change the text, text colour, background, size, weight, alignment, padding or corners. The app
   shows the change at once. **Undo** puts it back.
3. **Review change** finds where it comes from in the source:
   - **Found where it comes from**: the files and lines, and the diff. **Apply change** writes
     exactly that diff, only if the files have not changed since, and the dev server reloads.
   - **Albert will make this change**: the reason, such as the text being built from data, written
     in several places, or styled with utility classes. **Ask Albert** sends it as a task.
4. **Done** turns editing off.

Direct edits are offered for React with TypeScript, Next.js, Vite with React, and plain HTML, CSS
and JavaScript, for text written once in the source and for styles in plain CSS or CSS modules.

## Task board

**Tasks**, in the ⋮ menu at the top right, opens every task as a board with five columns:
Planned, Active, Blocked (waiting for you, or failed), Verifying and Completed. Each card shows
its progress through plan, build, verify, approve and accept; what it is waiting for; its checks
and files; and why it failed if it did. Open a card to continue the task. **List** shows the same
tasks as a list you can search. The board updates by itself while tasks run.

## Browser tests

**Test** in the top bar runs your repository's Playwright tests (`e2e/*.spec.ts`) against the
preview, in a browser.

1. **Write browser tests** asks Albert for them as a normal task, through the usual plan and diff
   approvals: one file per journey people take through the app, a `playwright.config.ts` that runs
   against the preview, and `@playwright/test` in `package.json`.
2. **Install** runs your package manager's install, so the test runner is there.
3. A browser: a Chrome, Edge or Chromium already installed is used. Only when there is none does
   the panel offer Playwright's Chromium, about 150 MB, downloaded when you click.
4. **Run tests** starts the app if it is not running, runs every test (or one file), and shows the
   results. Each failure has its error, its place in the test, its screenshot and its trace, with
   **Fix with Albert**, **Open the test** and **Run again**.

The files are yours: run them from your own terminal with `npx playwright test`, change them, and
commit them. Installing, downloading a browser and running tests are each your click, and each is
recorded in the evidence ledger.

## Requirements

**Requirements**, in the ⋮ menu, keeps what the app must do as a list you can check.

1. **Draft requirements**: paste a specification (a brief, a list, a ticket). With a model
   connected, it drafts one checkable requirement per behaviour; without one, it uses the
   specification's own bullets and sentences. Or choose **Write them myself**.
2. Edit, reorder, add and remove, then **Save requirements**. The list is saved in the repository
   as `.albertcode/requirements.json`; each requirement keeps its number (R1, R2…) when you edit.
3. Each requirement then shows **Complete**, **Partial**, **Failed** or **Missing**, from the latest
   browser test run and the tasks built for it, with the reason and the evidence.
4. One action moves it on: **Build with Albert** for a missing one, **Fix with Albert** for a failed
   one, **Add a test** for one nothing checks yet. Each puts a request in the chat for you to send.
   **Check now** runs the browser tests again.

A browser test belongs to a requirement when its title starts with the requirement's number in
brackets, for example `test('[R3] notes can be searched', …)`. A task belongs to it when its
request says "(requirement R3)". The actions word their requests that way for you.

## Architecture

**Architecture**, in the ⋮ menu, shows what the open repository is made of, read from its files.

- **Three columns.** People use (frontends, web pages), it runs (API servers, background jobs), it
  relies on (databases, caches, sign-in, queues, file storage, outside services).
- **Evidence.** Select a part to see the files that put it on the map, what it connects to and the
  file that shows each connection, and its routes, pages and data models with their files and lines.
  Click a file to open it beside the map.
- **What it reads.** `package.json`, `pyproject.toml`, `requirements*.txt` and `go.mod` for the parts;
  `docker-compose.yml` for the services that run beside the app; `.env.example` for the outside
  services it is set up for (names only); the code for routes (Express, Fastify, FastAPI, Flask,
  Django, Next.js), pages (Next.js, React Router) and data models (Prisma, SQLAlchemy, Django,
  SQLModel, Mongoose, Drizzle).
- **Read again** reads the files afresh; otherwise the map is kept for half a minute.

## Approvals

In governed mode there are two:

1. **The plan.** You see the goal, the files it expects to change, the steps, the test plan, the
   risk and how to roll back. Rejecting it discards the task.
2. **The result.** You see the diff, the test and check results, and the review. Accepting applies
   the change to your repository. Acceptance is refused if a file it changes was edited since the
   task started.

Accepted changes are ordinary edits in your working tree: review them with `git diff`, commit them,
and undo them with Git.

## Terminal commands

| Command | |
|---|---|
| `/connect [provider]` | Connect a provider: its key, or the address of a local model |
| `/model [search]` | Choose a model |
| `/test [model]` | Check a model can drive AlbertCode |
| `/plan <request>` | Start a governed change |
| `/do <request>` | Work directly in your files, asking before each write |
| `/mode [governed\|direct\|auto\|ask]` | How plain requests are handled |
| `/chat [message]` | Talk to the model without starting a task |
| `/attach <paths>` | Give it files or screenshots |
| `/workspace` | Show or change the repository |
| `/tasks` | Recent tasks |
| `/preview` | Run this repository's app at an address of its own |
| `/commands`, `/agents` | Your custom commands and agents ([Extending](extending.md)) |
| `/mcp`, `/connectors` | MCP servers ([Extending](extending.md)) |
| `/ledger` | The record of what each task did, and whether it is intact |
| `/status` | The repository and model in use |
| `/help` | Every command |
| `/exit` | Leave (the service keeps running; `albertcode stop` stops it) |

## Scripting

Every step is also a subcommand, so AlbertCode fits a script or CI job:

```bash
TASK=$(albertcode create "Add tests for the billing module" --workspace ./repo | jq -r .id)
albertcode show    "$TASK"     # the task, as JSON
albertcode approve "$TASK"     # approve the plan
albertcode diff    "$TASK"     # the change
albertcode accept  "$TASK"     # apply it
```

`albertcode reject` discards a task, and `albertcode --help` lists every subcommand.

## Attachments

Paste or drop screenshots, logs and documents into the browser or VS Code, or use `/attach` in the
terminal. Images reach the model as images, if the model accepts them. If it doesn't, AlbertCode
tells you.

## Checking your setup

```bash
albertcode doctor
```

This shows which build tools AlbertCode can see, and where it found them.
