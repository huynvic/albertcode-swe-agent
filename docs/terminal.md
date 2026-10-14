# Terminal

`albertcode` is AlbertCode in your terminal: a full-screen interface on the same sessions as the browser
workspace, the classic terminal for one conversation printed as it goes, and a subcommand for every step so you
can script it. This page lists every command.

## Start it

```bash
cd your-project
albertcode
```

AlbertCode works on the folder you start it in. The first run starts the background service and, with no model
connected, opens **Connect a provider** for you (press <kbd>Esc</kbd> to skip). Then type in the box at the
bottom: a question, a change, or a `/command`.

| To | Run |
|---|---|
| Open the last session of this folder | `albertcode --resume` |
| Open one session | `albertcode --session 3f9c2a71` (its id, from `albertcode sessions`) |
| Use the classic terminal | `albertcode classic` |
| Open the browser workspace instead | `albertcode web`, or `albertcode --ui` |
| Work on another folder | `albertcode --workspace ~/code/shop` |
| See the version | `albertcode --version` |
| Leave | `/exit`, or <kbd>Ctrl</kbd> <kbd>C</kbd> twice. Sessions and runs keep going |
| Stop the background service | `albertcode stop` |

The full-screen interface needs a real terminal. Piped, on an AlbertCode service your organisation runs
(`--url`), or with `ALBERTCODE_CLASSIC=1`, `albertcode` opens [the classic terminal](#the-classic-terminal)
instead.

### Options

| Option | What it does |
|---|---|
| `--session ID` | Open this session in the terminal interface |
| `--resume` | Open the last session of this folder |
| `--mode MODE` | How a new session handles a request for a change: `governed`, `direct`, `direct_auto` or `ask` |
| `--model NAME` | The model a new session uses, as `provider` or `provider:model` |
| `--inline` | The terminal interface under your shell's last lines, not full screen |
| `--ui` | Open the browser workspace, signed in, on this folder |
| `--terminal` | Stay in the terminal (the default; useful when `ALBERTCODE_SURFACE=ui` is set) |
| `--workspace PATH` | The repository to work on, instead of the current folder |
| `--profile NAME` | Use a saved profile (see [Profiles](#profiles-the-older-way)) |
| `--provider NAME` | Use this provider for this run |
| `--url URL` | Talk to an AlbertCode service at this address, such as one your organisation runs, instead of the one on this computer |
| `--api-key KEY` | The key for that service (or set `ALBERTCODE_API_KEY`) |
| `--no-auto-start` | Do not start the local service if it is not running |
| `--version` | Print the version and exit |
| `-h`, `--help` | List the options and subcommands |

## The terminal interface

```text
 █████ █     ████  █████ ████  █████  ████  ███  ████  █████     (the name in solid letters)
 AlbertCode SWE Agent · Two human gates
 folder  ~/code/shop        model  gpt-5        mcp  1 connected

 Show the prices in euros
 ▸ 3 steps before answering
 Prices are kept in cents in cart.py …

 shop · gpt-5 · governed ❯ Add a 10% discount code for first orders
                                              tab modes · ctrl+p commands · ctrl+x h help ●
```

- **The conversation** scrolls above the box: your messages, Albert's answers, and each task as it goes, with
  Albert's steps under it: what he read, wrote and ran, a stage at a time. <kbd>Ctrl</kbd> <kbd>X</kbd> then
  <kbd>O</kbd> shows every step, or folds them again.
- **The prompt** says the folder, the model and the mode before **❯**. <kbd>Tab</kbd> moves to the next mode:
  governed, direct (asking before each write, or auto-approving) and ask only.
- **A gate** (a plan, a write, a change to accept) is a question in place of the box: the arrows choose an
  answer and <kbd>Enter</kbd> gives it, or its letter does: <kbd>a</kbd> approve or apply, <kbd>e</kbd> revise,
  <kbd>r</kbd> reject, <kbd>x</kbd> discard, <kbd>v</kbd> the diff, <kbd>d</kbd> the whole plan; for a write,
  <kbd>A</kbd> allow the rest and <kbd>n</kbd> decline. <kbd>Esc</kbd> goes between the gate and the box.
- **Lists** open under the conversation in place of the box: type to filter, the arrows to move,
  <kbd>Enter</kbd> to choose, <kbd>Esc</kbd> to close. Some rows have keys of their own, said under the list.
- **`@`** in the box finds a file of the repository to name; **`/`** lists the commands.

The sessions are the [browser workspace's](browser.md) too: a session started in one is there in the other, and
what Albert does shows in both as it happens.

### Commands in the terminal interface

| Command | What it does | Example |
|---|---|---|
| `/plan <request>` | A governed change: a plan for your approval first | `/plan Add rate limiting to the login endpoint` |
| `/do <request>` | Direct, asking before each write: in your files, every write waits for your OK | `/do Fix the typo in README.md` |
| `/direct auto <request>` | Direct, auto-approved: in your files, carried out without asking | `/direct auto Rename getUser to fetchUser` |
| `/new` | Start a new session. Also `/clear` | |
| `/sessions` | Open, rename, pin or delete sessions | |
| `/model`, `/mode` | The model for this session; the mode: `governed`, `direct`, `auto` or `ask`. Also `/models` | `/mode ask` |
| `/agent`, `/agents` | Work as one of this repository's custom agents | |
| `/connect` | Connect a model provider | |
| `/mcp` | MCP servers: on or off, reconnect, sign in, remove; add a connector, import from JSON; use a prompt or resource | |
| `/tasks [clear]` | Every task by where it stands; open one to answer its gate. Also `/task` | `/tasks` |
| `/ledger [task <id>]` | The evidence ledger, and whether its chain holds. Also `/evidence`, `/audit` | `/ledger task 3f2a91c0` |
| `/contract` | This repository's contract and what Albert has learned here. Also `/memory`, `/learned` | |
| `/requirements` | What the app must do, and what proves each part | |
| `/architecture [fresh]` | What this repository is made of and how its parts connect | `/architecture fresh` |
| `/checks` | The language checks run after each edit. Also `/diagnostics`, `/lsp` | |
| `/tools` | Tools and skills: switch them on for this repository. Also `/extensions`, `/skills` | |
| `/commands` | This repository's commands and yours: use, make or delete one. Also `/command` | |
| `/plugins` | Plugins: switch on or off, update, install or remove. Also `/plugin` | |
| `/preview [command\|stop]` | Run this repository's app, open it, read its output, stop it. Also `/run-app` | `/preview npm start` |
| `/test` | Browser tests: write them, install what they need, run them. Also `/e2e` | |
| `/diff` | This session's change, or your working tree's | |
| `/stop` | Stop what Albert is doing in this session | |
| `/rename [title]`, `/fork` | Rename this session; a new session holding its messages | `/rename Euro prices` |
| `/export [file]`, `/import <file>` | Save this session as a JSON file; open one saved that way | `/export euros.json` |
| `/attach <paths>` | Attach files to your next message. `/attach clear` drops them | `/attach logs/*.txt shot.png` |
| `/theme`, `/speed [fast\|balanced\|thorough]` | Colours; how much the model thinks at each step. Also `/themes` | `/speed thorough` |
| `/details`, `/timestamps`, `/sidebar` | Every step of the tasks here; the time of each message; the sidebar | |
| `/web` | Open this session in the browser workspace | |
| `/status` | The service, the engine and what is connected. Also `/doctor` | |
| `/help`, `/docs [words]`, `/keys` | Every command; the guide, searched; every key. Also `/guide` | `/docs browser tests` |
| `/exit` | Leave; the service and any run keep going. Also `/quit`, `/q` | |

Anything else starting with `/` is one of this repository's [custom commands](extending.md#custom-commands), or
`/server:prompt key=value …`, an MCP server's prompt filled in and put in the box to edit and send. A repository's
own `/requirements` or `/architecture` takes the place of AlbertCode's, since those names are not reserved.

### AlbertCode's own screens

Each opens as a list under the conversation, with the facts it is about above it.

**Tasks.** `/tasks` lists every task under **Waiting for you**, **Working**, **Failed**, **Done** and **Closed**,
with where each stands, its repository and when it started. <kbd>Enter</kbd> opens one: its request, plan, changed
files and checks, and, when no session holds it, the answers its gate takes: **Approve and build** or **Reject the
plan**; **Allow this write**, **Allow the rest** or **Decline this write**; **Accept into your files** or **Discard
the change**. **Open its session**, **Its change** and **Its evidence** go further. <kbd>Ctrl</kbd> <kbd>L</kbd>
opens a task's evidence from the list. `/tasks clear` deletes the history of every task that is not running, once
you type `delete`; the ledger keeps its record of each.

```text
/tasks
  Tasks
  WAITING FOR YOU
› Let customers order a loaf for tomorrow   Plan waiting for you · Governed · just now
  DONE
  Add a loaves endpoint test                Applied · Governed · 2h ago
```

**Evidence ledger.** `/ledger` lists every governed action, newest first, under whether the chain holds. Type to
find an entry (`plan approved`, a file's name, a task's id); <kbd>Enter</kbd> reads it, every field, and checks
it: its content still gives its hash, it links to the entry before it, and the next entry links to it.
<kbd>Ctrl</kbd> <kbd>T</kbd> shows only that entry's task; <kbd>Ctrl</kbd> <kbd>S</kbd> saves the whole chain
to a file, in your home folder unless you give a path.

**Contract and memory.** `/contract` shows the boundary every task here works within: what it may change, what it
never touches, how many files a task may change, the commands it may run and must pass, the reviews and approvals.
**Read the contract** shows it as written; **Redraft it from a description…** has the model write one from your
words, shown in full and saved only when you say so; each saved version can be read and restored; **What Albert
has learned here** lists the notes in `.albertcode/memory.md`.

**Requirements.** `/requirements` lists what the app must do under **Failed**, **Missing**, **Partial** and
**Complete**, with what proves each. <kbd>Enter</kbd> on one that is not complete puts the request to build it,
prove it or fix it in the box, to read and send. **Draft them from a specification…** turns a brief into
requirements, shown before they are kept; **Add one…** takes a title and, after a dash, a detail
(`Visitors can sign up — and confirm it by email`); <kbd>Ctrl</kbd> <kbd>D</kbd> removes one.

**Architecture.** `/architecture` shows the parts of the repository, their technology and where they live, and
how they connect, read from its own files. `/architecture fresh` reads them again.

**Language checks.** `/checks` lists each language and the checker that reads every edit Albert makes;
<kbd>Enter</kbd> on one that can be installed installs it, after you say yes.

**Tools and skills.** `/tools` lists the tools and skills this repository can run with; <kbd>Enter</kbd> switches
one on or off for it, saved at once and in force from the next task. One the contract bars says why, and
<kbd>Ctrl</kbd> <kbd>A</kbd> offers to allow it in the contract, showing the exact line first. **Save one of your
commands as a tool…** makes a tool of a command such as `npm run lint`; <kbd>Ctrl</kbd> <kbd>D</kbd> removes it.

**Commands.** `/commands` lists this repository's commands, yours and your plugins'. <kbd>Enter</kbd> puts one
in the box to use; **Make a command…** asks its name, what it does, what it sends (`$ARGUMENTS` marks where the
words after it go), when it is sent and where it is kept; <kbd>Ctrl</kbd> <kbd>D</kbd> deletes one.

**Plugins.** `/plugins` lists your plugins with what each brings. <kbd>Enter</kbd> switches one on or off,
<kbd>Ctrl</kbd> <kbd>U</kbd> checks for an update and <kbd>Ctrl</kbd> <kbd>D</kbd> removes one. **Install a
plugin…** takes a folder or an https Git address and shows everything it would add, its commands, agents and MCP
servers, before anything is installed. **Make a new plugin…** starts one from this repository's commands and
agents.

**The app.** `/preview` starts the app with its dev script (or `/preview npm start` with a command of yours) and
says in a notice when it runs, and where; the box stays free meanwhile. Running, `/preview` offers **Open it in
your browser**, **Its output**, **Restart it** and **Stop the app**, and, when it fails or answers with an error,
**Ask Albert to fix it**, which puts what went wrong in the box. `/preview stop` stops it.

**Browser tests.** `/test` says the next step and takes it when you say yes: Albert writes the tests (as a task),
the runner is installed, a browser is downloaded if there is none. Then **Run the tests** runs them in the
background and a notice gives the result; `/test` lists them, failed first. <kbd>Enter</kbd> on a failed test
offers **Fix with Albert** (a new session, given the error and how to run it), **Run this file again** and **Read
its error**.

**MCP prompts and resources.** In `/mcp`, **Use a prompt or resource…** lists what your connected servers offer.
A prompt asks for its answers, then fills the box to edit and send; a resource (one from a template, once its blank
is filled) is read by the service and goes with your next message.

### Keys in the terminal interface

| Keys | What they do |
|---|---|
| <kbd>Enter</kbd>, <kbd>Ctrl</kbd> <kbd>J</kbd> | Send; a new line |
| <kbd>Tab</kbd> | The next mode |
| <kbd>Esc</kbd> | Stop a run; go between the box and a gate; close a list |
| <kbd>Ctrl</kbd> <kbd>P</kbd> | Every command, and your sessions |
| <kbd>Ctrl</kbd> <kbd>C</kbd> | Clear the box; twice to leave |
| <kbd>Page Up</kbd>, <kbd>Page Down</kbd> | Scroll the conversation |
| <kbd>↑</kbd>, <kbd>↓</kbd> | Messages you sent before |
| <kbd>Ctrl</kbd> <kbd>X</kbd>, then a letter | <kbd>n</kbd> new session · <kbd>l</kbd> sessions · <kbd>m</kbd> models · <kbd>a</kbd> agents · <kbd>c</kbd> MCP servers · <kbd>d</kbd> diff · <kbd>k</kbd> connect a provider · <kbd>t</kbd> themes · <kbd>s</kbd> status · <kbd>h</kbd> help · <kbd>b</kbd> sidebar · <kbd>o</kbd> every step · <kbd>y</kbd> timestamps · <kbd>r</kbd> rename · <kbd>f</kbd> fork · <kbd>e</kbd> export · <kbd>w</kbd> open in the browser |

`/keys` lists them in the terminal, with the answers at a gate.

## The classic terminal

`albertcode classic` is AlbertCode's first terminal: one conversation at the `AlbertCode SWE Agent>` prompt,
printed as it goes, with nothing drawn over your scrollback. It is what `albertcode` opens on a shared service or
where the full-screen interface cannot run.

### Slash commands in the classic terminal

Type `/help` for a list you can search by typing. Every command, by area:

#### Working

| Command | What it does | Example |
|---|---|---|
| `/plan <request>` | Start a governed change: a plan for your approval first | `/plan Add rate limiting to the login endpoint` |
| `/do <request>` | Start a direct change in your real files, asking before each write | `/do Fix the typo in README.md` |
| `/direct [auto] <request>` | The same as `/do`; with `auto`, writes apply without asking | `/direct auto Rename getUser to fetchUser` |
| `/mode [governed\|direct\|auto\|ask]` | How plain requests are handled. Alone, lists the modes to pick from | `/mode ask` |
| `/chat [message]` | Talk to the model without starting a task. Inside it, `/do`, `/direct` and `/fast` start a task briefed on the conversation; `/back` returns | `/chat How would you structure the caching?` |
| `/new` | Start a fresh conversation. Running tasks carry on | `/new` |
| `/attach <paths>` | Give Albert files or screenshots with your next message. Globs work. `/attach` lists what is waiting; `/attach clear` drops it. Also `/add`, `/upload` | `/attach logs/*.txt shot.png` |
| `/tasks [clear]` | Recent tasks, to open one. `/tasks clear` deletes the history (you type `delete` to confirm) | `/tasks` |
| `/status` | The repository and model in use | `/status` |
| `/workspace` | Show or change the repository | `/workspace` |

#### Models and providers

| Command | What it does | Example |
|---|---|---|
| `/connect [provider]` | Connect a provider: its key, or a local model's address. Checked before it is saved | `/connect` |
| `/model [search]` | Choose a model: recent ones, every connected provider's, or any model ID. Also `/models` | `/model mini` |
| `/test [model]` | Check the model can drive AlbertCode, with one tool-calling request | `/test` |
| `/disconnect [all]` | Remove a provider's saved key from this computer, or every saved key | `/disconnect all` |
| `/pace [fast\|thorough]` | *thorough* keeps the independent reviews on every task; *fast* skips them for quicker solo work | `/pace fast` |
| `/profiles` | Pick one of the service's configured profiles (the older way) | `/profiles` |
| `/configure` | Add or replace a provider key and model (the older way) | `/configure` |

#### The repository

| Command | What it does | Example |
|---|---|---|
| `/contract` | Show the [contract](contract.md) in force | `/contract` |
| `/contract draft <words>` | Write a contract from a description | `/contract draft never touch src/payments, and run pytest before accepting` |
| `/contract edit` | Open the contract in your editor | `/contract edit` |
| `/contract history` | Every version, newest first | `/contract history` |
| `/contract restore [n]` | Make an earlier version active | `/contract restore 2` |
| `/memory [forget]` | What Albert has learned about this repository (`.albertcode/memory.md`); `forget` deletes it after asking. Also `/learned` | `/memory` |
| `/checks [install <id>]` | Which languages each edit is checked in; install a checker. Also `/diagnostics`, `/lsp` | `/checks install python` |
| `/preview [stop\|<command>]` | Run this repository's app at an address of its own, or stop it. Also `/run-app` | `/preview npm run dev` |
| `/cleanup` | How much disk the isolated task copies use, and clear them. Also `/disk` | `/cleanup` |

#### Evidence

| Command | What it does | Example |
|---|---|---|
| `/ledger [n]` | The last *n* entries of the evidence ledger (40 by default), and whether the chain still holds. Also `/evidence`, `/audit` | `/ledger 100` |
| `/ledger task <id>` | Only one task's entries | `/ledger task 3f2a91c0` |
| `/ledger check <#>` | Recompute one entry and both of its links | `/ledger check 57` |
| `/ledger export [file]` | The whole chain and its verification, for an auditor | `/ledger export ledger.json` |
| `/ledger evidence <task> [file]` | One change's evidence bundle | `/ledger evidence 3f2a91c0 change.json` |

#### Extending

| Command | What it does | Example |
|---|---|---|
| `/commands [new\|delete]` | Your custom commands; `new` makes one step by step. Run one as `/name`. Also `/command` | `/commands new` |
| `/agent [name\|default]` | Work as a custom agent; `default` goes back | `/agent reader` |
| `/agents [new\|delete]` | The custom agents here; `new` makes one step by step | `/agents new` |
| `/plugins [install\|update\|new\|enable\|disable\|remove]` | Plugins: commands, agents and MCP servers installed together. Also `/plugin` | `/plugins install https://github.com/example/review-kit` |
| `/tools` | Tools and skills: list them, then switch on by number. Also `/extensions`, `/skills` | `/tools` |
| `/tools list`, `/tools all` | List without asking; include the always-on built-in tools | `/tools all` |
| `/tools new`, `/tools forget <name>` | Save one of your commands as a tool; remove a saved tool | `/tools new` |
| `/tools allow <id>` | Add a skill or saved tool to the contract's allowed list, after showing you the exact line | `/tools allow skill.migrations` |
| `/mcp` | MCP servers: pick one to switch it on or off | `/mcp` |
| `/mcp add [name]` | Add a server: a local command or a remote URL | `/mcp add docs` |
| `/mcp list` | Every server, its status and tools | `/mcp list` |
| `/mcp auth <name>`, `/mcp logout <name>` | Sign in to a remote server; remove that sign-in | `/mcp auth linear` |
| `/mcp debug <name>` | Why a server is not working | `/mcp debug docs` |
| `/mcp connect <name>` | Connect again | `/mcp connect docs` |
| `/mcp tools <name>` | Switch a server's tools on or off one by one | `/mcp tools github` |
| `/mcp enable <name>`, `/mcp disable <name>` | Switch a server on or off | `/mcp disable docs` |
| `/mcp remove <name>` | Remove a server | `/mcp remove docs` |
| `/connectors [search]` | Add a ready-made server (Git, Playwright, PostgreSQL, web fetch…) in a couple of answers | `/connectors postgres` |
| `/mcp install <id> key=value…` | Add a connector without questions | `/mcp install postgres uri=postgresql://localhost/app` |
| `/mcp prompts`, `/mcp resources` | The prompts and resources servers offer | `/mcp prompts` |
| `/server:prompt [args]` | Use a server's prompt as your message | `/github:review-pr 128` |
| `/mcp attach <server> <uri>` | Attach a resource to your next message | `/mcp attach docs docs://api/orders` |

#### The screen

| Command | What it does |
|---|---|
| `/help` | Every command, in a list you search by typing |
| `/docs` | Where to read this documentation: in the browser (⋮ → **Documentation**, offline) or on the web. Also `/documentation` |
| `/clear` | Redraw the welcome screen (also `clear` or `cls`) |
| `/exit` | Close AlbertCode. Also `/quit`. The service keeps running |

Anything else starting with `/` is looked up as one of your [custom commands](extending.md#custom-commands),
then as an MCP prompt; if neither exists, AlbertCode says *Unknown command*.

#### Lists and pickers

Model lists, `/help`, `/tasks`, `/mcp` and the other pickers work the same way: type to filter, use
the arrow keys to move, <kbd>Enter</kbd> to choose and <kbd>Esc</kbd> to close.

## Subcommands

Every step of a task is also a subcommand, so AlbertCode fits scripts and CI. Each prints JSON.

| Subcommand | What it does |
|---|---|
| `albertcode classic` | The classic terminal: see [above](#the-classic-terminal) |
| `albertcode web` | Open the browser workspace, signed in, on this folder |
| `albertcode run "<message>" [--lane LANE] [--approve GATES] [--json] [--timeout S]` | One request in a new session, without the interface: see [Sessions from a script](#sessions-from-a-script) |
| `albertcode sessions [list\|show\|export\|import\|rename\|delete] [id] [file or title] [--search WORDS] [--json]` | The sessions the terminal and the browser share |
| `albertcode models [list\|use\|test] [provider:model] [--json]` | Connected providers and their models; the one new sessions use; a check that it answers |
| `albertcode stats [--json]` | What was done, and what it cost |
| `albertcode docs [words] [--limit N] [--json]` | Search this guide, offline |
| `albertcode status` | Whether the service is running here, and which version |
| `albertcode create "<request>" [--workspace PATH] [--provider NAME]` | Create a governed task and print it as JSON |
| `albertcode show <task>` | A task, as JSON: its state, plan and results |
| `albertcode approve <task>` | Approve its plan (approval 1) |
| `albertcode reject <task>` | Reject its plan, and delete its isolated copy |
| `albertcode diff <task>` | The change: the files and the unified diff, as JSON |
| `albertcode accept <task> [--workspace PATH]` | Apply the change to your repository (approval 2) |
| `albertcode rollback <task>` | Throw away a task you have not accepted, and its isolated copy. An accepted change is undone with Git |
| `albertcode compliance <task> [--format text\|json]` | The evidence for one change, set against the controls auditors assess |
| `albertcode checks [list\|install] [language]` | Which languages edits are checked in; install a checker |
| `albertcode mcp …` | Manage MCP servers: see [below](#albertcode-mcp) |
| `albertcode doctor` | Which build tools AlbertCode can see (node, npm, python3, pytest, git, go, cargo, dotnet…), and where |
| `albertcode stop` | Stop the background service, freeing its database and files |
| `albertcode uninstall [--check] [--yes] [--all]` | Remove AlbertCode. `--check` shows what would go; `--all` also removes settings, saved keys, sign-ins and task history |
| `albertcode configure …`, `login …`, `logout …`, `profiles` | [Profiles](#profiles-the-older-way) |

### Sessions from a script

```bash
albertcode run "Why does the cart total round down?" --lane ask
albertcode run "Add a test for the 10% code" --approve plan,result     # both gates answered for you
albertcode run "Rename getUser to fetchUser" --lane direct_auto --json # every event as a JSON line
albertcode sessions --search discount
albertcode sessions show 3f9c2a71
albertcode sessions export 3f9c2a71 discount.json
albertcode sessions rename 3f9c2a71 "Discount codes"
albertcode models use openai:gpt-5
albertcode stats
albertcode docs browser tests
albertcode status
```

`albertcode run` works in a new session, prints what Albert says and does, and ends with the answer or the change.
Without `--approve`, a governed change stops at its plan and the command exits with status `3`: open the session
(`albertcode --session <id>`, or in the browser) to read and answer it. `--approve` takes `plan`, `result`,
`writes` or `all`, comma separated.

### A task from a script

```bash
TASK=$(albertcode create "Add tests for the billing module" --workspace ./repo | jq -r .id)

albertcode show    "$TASK" | jq -r .state     # wait until it says plan_ready
albertcode approve "$TASK"                    # approval 1: the plan
albertcode show    "$TASK" | jq -r .state     # wait until it says completed
albertcode diff    "$TASK"                    # read the change
albertcode accept  "$TASK"                    # approval 2: apply it
```

A task moves through these states: `received`, `planning_queued`, `analysing`, `plan_ready`
(waiting for approval 1), `queued`, `implementing`, `verifying`, `reviewing`, then `completed`
(waiting for approval 2) or `review_blocked`, and finally `accepted`, `rejected`, `failed`,
`rolled_back` or `cancelled`.

### `albertcode mcp`

The same actions as `/mcp`, from a script:

```bash
albertcode mcp list
albertcode mcp add docs --command "npx -y @example/docs-mcp" --env DOCS_TOKEN=xyz
albertcode mcp add tracker --url https://mcp.example.com/mcp          # signs in with OAuth if it asks
albertcode mcp add search --url https://search.example.com/mcp --no-oauth --header "Authorization=Bearer xyz"
albertcode mcp auth tracker
albertcode mcp disable docs
albertcode mcp connectors
albertcode mcp install git repository=.
albertcode mcp remove docs
```

| Option | Meaning |
|---|---|
| `--command "…"` | A local server's command, quoted |
| `--url URL` | A remote server's address |
| `--env KEY=VALUE` | A variable for a local server (repeat it for more) |
| `--header KEY=VALUE` | A header for a remote server (repeat it for more) |
| `--no-oauth` | A remote server that uses headers, not a sign-in |

See [MCP servers](mcp.md).

### `albertcode checks`

```bash
albertcode checks                 # which languages are checked, and which can be installed
albertcode checks install python  # install Python's checker
```

Languages: `python`, `typescript` (TypeScript and JavaScript), `go`, `rust`, `c` (C and C++), `php`,
`shell` and `css` (CSS, SCSS and Less). See [Language checks](tasks-and-evidence.md#language-checks).

### `albertcode compliance`

```bash
albertcode compliance 3f2a91c0                       # readable summary
albertcode compliance 3f2a91c0 --format json > evidence.json
```

### `albertcode doctor`

Shows the folders AlbertCode searches for tools, then each build tool it looks for (`npm`, `npx`,
`node`, `python3`, `pytest`, `git`, `go`, `cargo`, `dotnet`), whether it found it, and where. Run it
when tests don't run, or run with the wrong tool. If a tool works in your own terminal but doctor
can't find it, your shell profile sets your `PATH` (a version manager does this): run
`albertcode stop`, then start `albertcode` again from that terminal.

### Profiles (the older way)

`/connect` and `/model` are the usual way to choose a model. Profiles are the older way, kept for
scripts and shared services:

```bash
albertcode configure --name work --provider <provider> --api-key <key> --model <model>
albertcode configure --name local --provider local --base-url http://localhost:11434/v1 --model <model>
albertcode profiles                   # list them
albertcode --profile work             # use one
albertcode login --name team --url https://albertcode.example.com --api-key <key>   # a shared service
albertcode logout --name team
```

`albertcode configure --help` lists the provider names. `--pace thorough|fast` sets the
[pace](models.md#pace) of a profile.

## Environment variables

| Variable | Effect |
|---|---|
| `ALBERTCODE_SURFACE` | `ui` makes `albertcode` open the browser by default; `terminal` keeps it in the terminal |
| `ALBERTCODE_CLASSIC` | `1` makes `albertcode` open the classic terminal instead of the full-screen one |
| `ALBERTCODE_API_KEY` | The key for a shared AlbertCode service (as `--api-key`) |
| `ALBERTCODE_CLIENT_TIMEOUT_SECONDS` | How long the terminal waits for the service to answer |
| `ALBERTCODE_LANGUAGE_SERVERS` | A folder of language checkers to use before the ones on your `PATH` |
| `HTTPS_PROXY`, `HTTP_PROXY`, `NO_PROXY` | Your network's proxy, for reaching your model provider |

Inside the [browser's terminal](browser.md#terminal), `ALBERTCODE_TERMINAL=1` is set, so your shell
scripts can tell they run there.
