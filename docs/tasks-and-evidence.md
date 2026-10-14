# Tasks and evidence

Every change AlbertCode makes is a **task**, and every task leaves **evidence**: what was planned,
what ran, what passed, who approved what. This page covers finding tasks, reading their evidence, and
the checks that run along the way.

## The task board

**Tasks…**, in the browser's **Evidence** menu (or `/tasks`), shows every task on a **Board**, in columns for
where each stands:

| Column | Tasks that are |
|---|---|
| **Planned** | Being planned, or approved and about to start |
| **Active** | Being built |
| **Blocked** | Waiting for you (a plan, a diff, a write, or a review's findings), or failed |
| **Verifying** | Running checks and reviews |
| **Completed** | Done: applied, or finished with nothing to change |

Tasks you rejected, discarded or stopped leave the board; **List** still finds them.

Each card shows how far the task has come (plan, build, verify, approve, accept), what it is waiting
for (*Plan waiting for you*, *Diff waiting for you*), its checks and files, and why it failed if it
did. Open a card to pick the task up where it is. **List** shows the same tasks as a list you can
search by request, file or repository. The board updates by itself while tasks run.

**Clear task history** deletes the history (your repositories are not touched).

Elsewhere:

| Interface | How |
|---|---|
| Terminal | `/tasks` lists every task by where it stands; open one to read it and answer its gate (see [AlbertCode's own screens](terminal.md#albertcodes-own-screens)). `albertcode show <task>` prints one as JSON |
| Classic terminal | `/tasks` lists recent tasks to open |
| VS Code | **Task History** |

A task no session holds, such as one started from a script or from VS Code, is answered right there: **Approve
and build** or **Reject**, then **Accept into your files** or **Discard**, the same answers its gate takes in a
session. One a session holds opens in that session (**Open its session**).

## A task's evidence

Open a task, or look at its result card, to see:

- **The plan you approved**: goal, files, steps, test plan, security, rollback and assumptions.
- **The steps**: every file read, search, command, edit and check, each one opening to its detail.
- **Verification**: each check command, with its exit code.
- **The reviews**: the security and quality findings, each with its severity.
- **The diff**.
- **Who approved what, and when.**

**Export evidence** (browser) or `/ledger evidence <task> [file]` (terminal) saves one change's
evidence as a file. For an auditor, `albertcode compliance <task>` sets the evidence against the
controls they assess:

```bash
albertcode compliance 3f2a91c0                        # to read
albertcode compliance 3f2a91c0 --format json > evidence.json
```

## The evidence ledger

The ledger is the record of everything AlbertCode did, in order: tasks created, plans approved,
commands run, files changed, changes accepted, keys connected, files made in the Files panel, browser
tests run, releases recorded, and more. Each entry is linked to the one before it, so changing or
deleting an entry breaks the chain, and the break is found.

| Interface | How |
|---|---|
| Browser | **Evidence ledger…** in the **Evidence** menu: whether the chain holds, the entries by kind (**Decisions**, **Tasks**, **Tool calls**, **Failures**), each opening to every field with **Check this entry**, **Only this task** and **Open the task**; **Export the chain** and **Check the chain again** |
| Terminal | `/ledger`: type to find an entry, <kbd>Enter</kbd> reads and checks it, <kbd>Ctrl</kbd> <kbd>T</kbd> only its task, <kbd>Ctrl</kbd> <kbd>S</kbd> saves the chain to a file. `/ledger task <id>` |
| Classic terminal | `/ledger [n]`, `/ledger task <id>`, `/ledger check <#>`, `/ledger export [file]`, `/ledger evidence <task> [file]` |
| Classic page | **Evidence ledger** in the ⋮ menu: the latest entries, **Load older entries**, **Check the whole chain**, **Export ledger**, **Reload** |
| VS Code | **Evidence Ledger** |

**Check the whole chain** recomputes every entry and every link from the first. **Export ledger**
saves the whole chain with its verification, for an auditor to recompute independently.

> [!NOTE]
> The ledger is **tamper-evident, not tamper-proof**. It shows that an entry was changed or removed;
> it cannot stop someone with access to your account from deleting the whole file. Export it to keep
> a copy elsewhere.

## Repository memory

As tasks run, Albert notes what would save the next task the same work: conventions, where things
live, traps. The notes are in your repository, in `.albertcode/memory.md`, and each one is a write you
approve like any other change.

| To | Do |
|---|---|
| Read them | `/memory` (terminal), **What It Has Learned Here** (VS Code), or open the file |
| Correct one | Edit the file: the next task believes what it says |
| Forget them | `/memory forget` (asks first), or delete the file, then commit |

## Checks that could not run

The repository's own checks (its tests, type checks, lint and build) run on every governed change. A
check that cannot run here proves nothing about the change, so it is recorded as **Not run**, with why,
and never sent back to Albert as a defect to repair:

- its tool is not installed (`No module named pytest`);
- the project's packages are not installed yet: a JavaScript project with no `node_modules`, tests that
  stop because a package the project declares cannot be imported, or a script whose declared program is
  missing;
- the type check needs TypeScript and the project has not installed it (it is never fetched from the
  registry to check).

A test that ran and failed, an import of the project's own code, or a package the project does not
declare is still a failure, and Albert repairs it. A check your contract names is required evidence, so
it fails when it cannot run.

**Example.** In a new project, Albert writes `api/requirements.txt` with `fastapi` and a test that imports
it. `python -m pytest` stops with *No module named 'fastapi'*, so the check shows *Not run: the tests
could not start, because fastapi is declared by the project and not installed for this Python*, and the
change goes to review instead of round the repair rounds. Install the packages
(`pip install -r requirements.txt`) and the check runs next time.

## Language checks

After each edit, the file is checked by its language's own checker, the one your editor would use,
and the errors **that edit introduced** go straight back to Albert while it still has the change in
front of it. Errors that were already there, and imports a machine has not installed, are left out.

| Language | Checker | Files |
|---|---|---|
| Python | pyright | `.py`, `.pyi` |
| TypeScript and JavaScript | TypeScript's language server | `.ts`, `.tsx`, `.js`, `.jsx`, `.mjs`, `.cjs`, `.mts`, `.cts` |
| Go | gopls | `.go` |
| Rust | rust-analyzer | `.rs` |
| C and C++ | clangd | `.c`, `.h`, `.cpp`, `.cc`, `.hpp`… |
| PHP | Intelephense | `.php` |
| Shell | bash-language-server and shellcheck | `.sh`, `.bash` |
| CSS, SCSS and Less | VS Code's CSS language server | `.css`, `.scss`, `.less` |

A checker is used only when it is installed. **Language checks…** (the browser's **Settings** menu, or the
palette), `/checks` or `albertcode checks` (terminal) and **Language Checks** (VS Code) show which are in use,
and install the rest in one click or command:

```bash
albertcode checks install python
albertcode checks install typescript
```

Nothing from your repository is run by a checker: each is found outside your repository, and settings
that would let a repository choose its own program are fixed.

## Disk space

Each governed task works in its own isolated copy of the repository, kept until you accept or discard
it. `/cleanup` (terminal) shows how much space the copies use and clears them.

## When a run goes in circles

A model that has lost its place, or sees no way forward, can ask for the same things over and over: the
same page, the same file, the same failing command, getting the same answer each time. Every one of those
rounds is a request to the model you pay for, so AlbertCode stops it early instead of letting it run to the
end of its rounds:

| Rounds in a row that only repeated earlier steps, with the same answers | What happens |
|---|---|
| 3 | The answers tell Albert it is going in circles, and to take a different step or finish |
| 5 | Its tool calls are refused, and it is asked to finish with what it has |
| 7 | The run stops before the model is asked again |

A round with anything new in it, such as a file read for the first time, a changed file, or a command
whose output changed, starts the count again, so long work that is moving is never stopped this way.
What was written is kept: a governed change goes on to its checks and reviews as it stands, and a run
stopped this way is never carried on with a fresh budget, because that would only start the circle again.

**Example.** Albert builds a chess page in `index.html`, then opens it in the browser to look, and opens
it again, and again, getting the same page each time. A few rounds later the run stops, and the task
says:

```text
Stopped at round 11: the last 7 rounds only repeated steps already taken, and each was answered
exactly as before, so the work was going in circles. It was stopped rather than left to spend more on
the model. Nothing it had already written is lost.
```

`index.html` is there: a governed change is checked and reviewed as it stands, and in Direct mode the
message also names the files already written. Ask again with what is still missing named ("the pieces
don't move when clicked"), or in a smaller piece.

Pictures don't fill the conversation either. A screenshot counts at what it costs the model (about as
much as a page of text), only Albert's two latest screenshots stay in the conversation, and the
pictures you attached always stay with your request.

## Pace

At the *thorough* pace (the default), every governed change gets an independent security review and an
independent quality review. At the *fast* pace these are skipped: about half the model calls, for solo
iteration. The checks, the contract and both approvals apply at either pace. Switch with `/pace fast`
or `/pace thorough`.
