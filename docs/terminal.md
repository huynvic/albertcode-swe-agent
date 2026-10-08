# Terminal

`albertcode` is AlbertCode in your terminal: a conversation with Albert, plus a subcommand for every
step so you can script it. This page lists every command.

## Start it

```bash
cd your-project
albertcode
```

AlbertCode works on the folder you start it in. The first run starts the background service and,
with no model connected, opens [`/connect`](#models-and-providers) for you (press <kbd>Esc</kbd> to
skip). Then type at the `AlbertCode SWE Agent>` prompt: a question, a change, or a `/command`.

| To | Run |
|---|---|
| Open the browser interface instead | `albertcode --ui` |
| Work on another folder | `albertcode --workspace ~/code/shop` |
| See the version | `albertcode --version` |
| Leave | `/exit`, or <kbd>Ctrl</kbd> <kbd>D</kbd> / <kbd>Ctrl</kbd> <kbd>C</kbd> at the prompt |
| Stop the background service | `albertcode stop` |

### Options

| Option | What it does |
|---|---|
| `--ui` | Open the browser interface, signed in, on this folder |
| `--terminal` | Stay in the terminal (the default; useful when `ALBERTCODE_SURFACE=ui` is set) |
| `--workspace PATH` | The repository to work on, instead of the current folder |
| `--profile NAME` | Use a saved profile (see [Profiles](#profiles-the-older-way)) |
| `--provider NAME` | Use this provider for this run |
| `--url URL` | Talk to an AlbertCode service at this address, such as one your organisation runs, instead of the one on this computer |
| `--api-key KEY` | The key for that service (or set `ALBERTCODE_API_KEY`) |
| `--no-auto-start` | Do not start the local service if it is not running |
| `--version` | Print the version and exit |
| `-h`, `--help` | List the options and subcommands |

## Slash commands

Type `/help` for a list you can search by typing. Every command, by area:

### Working

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

### Models and providers

| Command | What it does | Example |
|---|---|---|
| `/connect [provider]` | Connect a provider: its key, or a local model's address. Checked before it is saved | `/connect` |
| `/model [search]` | Choose a model: recent ones, every connected provider's, or any model ID. Also `/models` | `/model mini` |
| `/test [model]` | Check the model can drive AlbertCode, with one tool-calling request | `/test` |
| `/disconnect [all]` | Remove a provider's saved key from this computer, or every saved key | `/disconnect all` |
| `/pace [fast\|thorough]` | *thorough* keeps the independent reviews on every task; *fast* skips them for quicker solo work | `/pace fast` |
| `/profiles` | Pick one of the service's configured profiles (the older way) | `/profiles` |
| `/configure` | Add or replace a provider key and model (the older way) | `/configure` |

### The repository

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

### Evidence

| Command | What it does | Example |
|---|---|---|
| `/ledger [n]` | The last *n* entries of the evidence ledger (40 by default), and whether the chain still holds. Also `/evidence`, `/audit` | `/ledger 100` |
| `/ledger task <id>` | Only one task's entries | `/ledger task 3f2a91c0` |
| `/ledger check <#>` | Recompute one entry and both of its links | `/ledger check 57` |
| `/ledger export [file]` | The whole chain and its verification, for an auditor | `/ledger export ledger.json` |
| `/ledger evidence <task> [file]` | One change's evidence bundle | `/ledger evidence 3f2a91c0 change.json` |

### Extending

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

### The screen

| Command | What it does |
|---|---|
| `/help` | Every command, in a list you search by typing |
| `/docs` | Where to read this documentation: in the browser (⋮ → **Documentation**, offline) or on the web. Also `/documentation` |
| `/clear` | Redraw the welcome screen (also `clear` or `cls`) |
| `/exit` | Close AlbertCode. Also `/quit`. The service keeps running |

Anything else starting with `/` is looked up as one of your [custom commands](extending.md#custom-commands),
then as an MCP prompt; if neither exists, AlbertCode says *Unknown command*.

### Lists and pickers

Model lists, `/help`, `/tasks`, `/mcp` and the other pickers work the same way: type to filter, use
the arrow keys to move, <kbd>Enter</kbd> to choose and <kbd>Esc</kbd> to close.

## Subcommands

Every step of a task is also a subcommand, so AlbertCode fits scripts and CI. Each prints JSON.

| Subcommand | What it does |
|---|---|
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
| `ALBERTCODE_API_KEY` | The key for a shared AlbertCode service (as `--api-key`) |
| `ALBERTCODE_CLIENT_TIMEOUT_SECONDS` | How long the terminal waits for the service to answer |
| `ALBERTCODE_LANGUAGE_SERVERS` | A folder of language checkers to use before the ones on your `PATH` |
| `HTTPS_PROXY`, `HTTP_PROXY`, `NO_PROXY` | Your network's proxy, for reaching your model provider |

Inside the [browser's terminal](browser.md#terminal), `ALBERTCODE_TERMINAL=1` is set, so your shell
scripts can tell they run there.
