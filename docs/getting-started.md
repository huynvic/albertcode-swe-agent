# Getting started

This takes about five minutes: install, connect a model, run a first task.

## 1. Install

macOS and Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh
```

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.ps1 | iex
```

The installer shows what it found and what it would do, then asks `Proceed? [Y/N]`. Nothing
changes before you answer. When it finishes, open a new terminal so it picks up the `albertcode`
command. [Installation](installation.md) has the details.

## 2. Start AlbertCode in a repository

```bash
cd your-project
albertcode
```

AlbertCode shows the repository it is working on and the model it will use. The first time, it
starts a small local service in the background, which keeps running between sessions.
`albertcode stop` stops it.

For a browser interface instead, run `albertcode --ui`.

## 3. Connect a model

```text
/connect
```

Pick a provider and enter its key, or the address of a model running on your machine. AlbertCode
checks the key or address works before saving it. Then choose a model with `/model`.
[Models](models.md) lists what is supported.

## 4. Ask for a change

Type what you want done:

```text
› The /login endpoint returns 500 when the password is empty. Find out why, fix it,
  and add a test.
```

AlbertCode reads the repository and comes back with a plan: what it will change, which files it
expects to touch, how it will test the change, and how risky it is.

## 5. Approve the plan

Read the plan. Approve it to start the work, or reject it and say what you want instead. Nothing has
been written yet.

## 6. Review the result

AlbertCode makes the change in an isolated copy of your repository, runs your tests and checks, and
reviews the change. It then shows you the diff and what passed. Your own files are still untouched.

## 7. Accept, or discard

Accept to apply the change to your repository, or discard it. If you edited the same files while it
worked, acceptance is refused rather than overwriting your edits.

Commit the accepted change with Git as you normally would. Git is also how you undo one.

## Next

- [Using AlbertCode](usage.md): modes, commands, and scripting.
- [Extending](extending.md): your own commands, agents and MCP servers.
