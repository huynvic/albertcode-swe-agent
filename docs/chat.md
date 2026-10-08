# Chatting with Albert

Albert is AlbertCode's agent. You talk to it the same way in the terminal, the browser and VS Code:
ask a question, or say what you want changed. This guide covers the conversation itself: what to
type, the approvals, sessions, attachments and shortcuts.

- New to AlbertCode? Read [How AlbertCode works](how-it-works.md) first.
- Looking for one command? See the [terminal reference](terminal.md) or the
  [browser reference](browser.md#keyboard-shortcuts).

## Where you type

| Interface | The message box | Send |
|---|---|---|
| Terminal | The `›` prompt after you run `albertcode` | <kbd>Enter</kbd> |
| Browser | The box at the bottom of **Chat** | <kbd>Ctrl</kbd> <kbd>Enter</kbd> (<kbd>⌘</kbd> <kbd>Enter</kbd> on a Mac), or the arrow button. <kbd>Enter</kbd> adds a line |
| VS Code | The box at the bottom of the AlbertCode panel | <kbd>Enter</kbd>, or the send button |

## Asking a question

Ask anything about the repository. Albert reads the code to answer, and changes nothing.

```text
› What does this project do, and where are the tests?
› Where is the session cookie set, and how long does it last?
› Why would /api/orders return 403 for an admin?
› Which of our dependencies are more than two major versions behind?
```

Good questions name what you are looking at: a file, a function, an endpoint or an error message.
Paste the error itself rather than describing it.

## Asking for a change

Say what you want, and how you will know it is done:

```text
› The /login endpoint returns 500 when the password is empty. Make it return 400 with
  "Password is required", and add a test.

› Add a "Remember me" checkbox to the sign-in form. When ticked, the session lasts 30 days
  instead of one. Keep the existing tests passing.

› Rename the `cust` table's `nm` column to `name`, with a migration, and update every query.
```

What happens next depends on the [mode](how-it-works.md#modes):

- **Governed** (the default): Albert writes a plan and waits for your approval. See
  [Approvals](#approvals).
- **Direct**: Albert works in your files straight away, asking before each write (or not, with
  auto-approve).
- **Ask only**: Albert offers the change and waits. In the browser, **Start a governed change?**
  shows the request it would send: **Yes, plan it**, **Do it directly**, or keep talking. In the
  terminal: `p` plan it, `d` do it directly, `e` edit the words, `n` keep talking.

### Choosing for one request: `/plan` and `/do`

Start a message with `/plan` or `/do` to choose for that request, whatever the mode:

```text
› /plan Split billing/invoice.py into invoice_model.py and invoice_pdf.py
› /do Fix the typo in the README's install section
```

`/plan` always starts a governed change; `/do` always starts a direct one. In the terminal,
`/direct <request>` is `/do`, and `/direct auto <request>` applies each write without asking.

### Changing the mode

| Interface | How |
|---|---|
| Terminal | `/mode` lists the modes; `/mode governed`, `/mode direct`, `/mode auto` or `/mode ask` switches |
| Browser | The mode chip under the message box (**Governed**, **Direct**, **Ask only**). For Direct, choose **Ask each write** or **Auto-approve** beside it |
| VS Code | The **Governed**, **Direct** and **Ask only** buttons above the message box; for Direct, **Ask each write** or **Auto-approve** |

The browser's [command palette](browser.md#the-command-palette) (<kbd>Ctrl</kbd> <kbd>K</kbd>) also
has every mode.

## Approvals

A governed change stops twice for you.

### 1. The plan

The plan says what will change and why: the goal, the files and how each changes, the steps, the
test plan, security points, how to roll it back, and the assumptions it made.

| Interface | Your choices |
|---|---|
| Browser | **Approve and implement**, **Reject**, or type what should change and send it: a revised plan comes back |
| VS Code | The plan opens in the editor. **Approve plan**, **Ask for changes** or **Reject** |
| Terminal | `approve`, `details` (read the whole plan), `ask` (ask about the plan; answering changes nothing), `revise` (say what should change), `model` (choose another model and plan again), `reject`. If the planner asked you something, `answer` replies to it |

Rejecting discards the task. Nothing has been written at this point.

### 2. The result

When the change is built, tested and reviewed in its isolated copy, you see the outcome: the files
changed, the checks that ran and their results, the reviews' findings, and the steps it took.

| Interface | Your choices |
|---|---|
| Browser | **Review the diff**, **Accept into repository**, **Export evidence**, **Discard**, or say what is not right: work continues in the same copy |
| VS Code | The diff and a summary open in the editor. **Accept changes**, **Ask for changes** or **Roll back** (discards the copy) |
| Terminal | `apply`, `ask` (ask about the result), `revise` (ask for changes), `discard` |

If a review blocked the change, accepting is not offered. Say how to address the findings and
Albert works on it again (**Ask for changes** in VS Code, `revise` in the terminal), or discard it.
In the terminal you may also `keep` the isolated copy to inspect it yourself, or `delete` it.

Accepting is refused if you changed a file the change also touches since the task started. Look at
your edit, then run the request again.

### Direct writes

In Direct with **Ask each write**, each write and each command waits for you:

| Interface | Your choices |
|---|---|
| Browser and VS Code | **Approve**, **Approve all** (the rest of this task's writes), or **Decline**. A command shows **Run it** and **Run, and stop asking** instead |
| Terminal | `a` approve, `A` approve all the rest of this task's writes, `d` decline |

With **Auto-approve** (`/mode auto`, or `/direct auto` for one request) writes apply as they come.
Either way, Git is your undo: `git diff` shows what changed and `git restore` puts it back.

## While Albert works

- **Steps.** Each step appears as it happens: what Albert read, searched, ran and changed. Open a
  step to see its output or diff. In the terminal, `/tasks` and then a task's steps open the same
  detail.
- **Stop.** The **Stop** button (browser and VS Code) ends the run. A governed change's isolated copy
  is kept until you discard it.
- **It keeps going.** A run belongs to the service. Start a new session, switch to another, or
  close the window, and it carries on. Its session in the sidebar shows a moving dot while it
  works and an amber one when it is waiting for you.

## Follow-ups

Keep talking in the same session to build on what was just done:

```text
› Now add the same validation to /register.
› Why did you change the session middleware?
› Undo the change to config.py but keep the rest.
```

A follow-up to a change starts a new task that continues the previous one: Albert is told what the
previous task changed and why, so you don't repeat yourself.

## Sessions

A session is one conversation. Nothing said in one session reaches another.

| To | Browser | Terminal | VS Code |
|---|---|---|---|
| Start a new session | **New session**, <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Shift</kbd> <kbd>O</kbd>, or `/new` | `/new` | The **+** button, or `/new` |
| Find a session | **Search sessions** in the sidebar, or <kbd>Ctrl</kbd> <kbd>K</kbd> | `/tasks` lists the tasks | The **Chats** button, or `/chats` |
| Open one again | Click it in the sidebar | | Pick it in **Chats** |
| Rename | Double-click its title, or the pencil | | |
| Delete | The **×** on its row | | |

Opening a session picks it up where it was: its words, its run (still working, or waiting for an
approval you can give now), and the folder it was about. The sidebar groups sessions by day: Today,
Yesterday, Previous 7 days, Previous 30 days and Older.

**Clear this chat**, in the ⋮ menu, empties the session open now.

### Chats about one thing

When you start a chat from a button on one of AlbertCode's pages, the chat is filed under the thing
that button is about. When a thing has more than one chat, the sidebar shows it as **one row that
opens to its chats**, with a count:

```text
TODAY
  ▾ Add a note and see it listed     3
      Repair slice 1 …
      Repair slice 1 …
      Build slice 1 …
  ▸ Notes API                        2
    What does this repository do?
```

| Started from | Filed under |
|---|---|
| The **Build** stage: build a slice, **Repair**, **Roll back** | That slice |
| A box on the System map: **Ask Albert**, **Fix with Albert**, **Wire it into the app** | That part |
| **Operate** → **Run**: **Fix with Albert** on a part that does not run | That part |
| The **Verify** stage: **Fix with Albert** on one problem | The thing the problem is about: the part, the browser test, the requirement or the connection |
| The **Verify** stage: several problems at once | *Problems in* the environment |
| **Operate** → **Release**: **Fix with Albert**, **Roll back to this** | That environment's releases |
| **Requirements**: **Build with Albert**, **Fix with Albert**, **Add a test** | That requirement |
| **Test**: **Fix with Albert** on a failing test | That test |

So a problem fixed from the **Verify** stage joins the chats you already had about that part or test, and
repairing the same slice three times stays together. Chats you start by typing are not filed under
anything. A topic belongs to its folder: slice 1 of two different repositories are two topics.

Click a topic's row to open or close it; AlbertCode remembers your choice. A topic opens by itself
when it holds the chat you are in. Searching finds chats inside topics and opens their topic.

## Attachments

Give Albert screenshots, logs, documents and other files with your message.

| Interface | How |
|---|---|
| Browser | Paste, drag onto the page, or the paperclip button. Each file shows as a tile you can remove before sending |
| VS Code | Paste, drop onto the panel, or the attach button |
| Terminal | `/attach <paths>`: one or more paths, globs work (`/attach logs/*.txt screenshot.png`). `/attach` alone lists what is waiting; `/attach clear` drops it |

Files up to 500 MB are accepted. What you attach goes with your next message only. Pictures reach
the model as pictures when the model accepts images; when it doesn't, AlbertCode tells you rather
than letting the model guess.

## Models

| To | Browser | Terminal | VS Code |
|---|---|---|---|
| Choose a model | The model chip, <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>'</kbd>, or `/model` | `/model [search]` | **Choose Model**, or `/model` |
| Connect a provider | **Connect a provider**, or `/connect` | `/connect [provider]` | **Connect a Provider**, or `/connect` |
| Test the model | | `/test [model]` | **Test the Chosen Model** |

See [Models](models.md).

## Commands, agents and MCP prompts in the chat

- **Custom commands.** `/review src/cart.py` sends the text your `review` command holds. A
  plugin's command is also reachable as `/plugin:command`. See [Extending](extending.md).
- **Custom agents.** `/agent reader` works as the `reader` agent from now on; `/agent default` goes
  back. In the browser, the agent chip beside the mode does the same.
- **MCP prompts.** `/server:prompt arguments` uses a prompt an MCP server offers, such as
  `/github:review-pr 128`. See [MCP servers](mcp.md).

## Shortcuts

| Keys | Browser | VS Code |
|---|---|---|
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Enter</kbd> | Send | |
| <kbd>Enter</kbd> | New line | Send |
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>K</kbd> | Command palette: every command and session | |
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>'</kbd> | Choose a model | |
| <kbd>Ctrl</kbd>/<kbd>⌘</kbd> <kbd>Shift</kbd> <kbd>O</kbd> | New session | |
| <kbd>Esc</kbd> | Close the open dialog | |

The [browser reference](browser.md#keyboard-shortcuts) lists every shortcut, including the Files
panel, the terminal and the folder picker.

## Writing good requests

- **Say what done looks like.** "Return 400 with a message", "the existing tests still pass", "add a
  test that fails before the fix".
- **Name the place when you know it.** A file, a function, an endpoint or a page.
- **One change at a time.** Two unrelated changes are two requests; each gets its own plan, diff and
  evidence.
- **Paste the evidence.** The full error, the failing test's output, a screenshot.
- **Let the plan be your review.** If the plan is wrong, say what to change before approving it:
  it is cheaper than reviewing a wrong diff.
