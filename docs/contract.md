# The contract

A repository can carry a **contract**: a file that sets what AlbertCode may do there. Which paths a
change may touch and how big it may be, which commands may run, which checks must pass, which reviews
are required, and who may approve. It is the boundary every task in that repository works under.

With no contract, sensible defaults apply: a change keeps to the files its plan named, files that look
like secrets are never changed, credentials are never written into files, and both reviews run.

## Where it lives

AlbertCode reads the first of these it finds at the root of the repository:

```text
albertcode.contract.toml
albertcode.contract.json
.albertcode/contract.toml
.albertcode/contract.json
```

The contract is read from **your** repository, under version control, never from Albert's isolated
copy, so a task cannot widen the limits that govern it. If the file changes while a task is under way,
accepting that task is refused until it is planned again.

## Write one

| Interface | How |
|---|---|
| Browser | **Contract** in the ⋮ menu (or **Boundary** on the repository card): describe what you want, read the draft, then save it |
| Terminal | `/contract draft <words>`, or `/contract edit` to open it in your editor |
| VS Code | **Write a Contract** |

```text
› /contract draft never touch anything under src/payments or infra, run pytest before
  accepting, and allow at most 15 files per change
```

AlbertCode drafts the file from your words and shows it to you before saving. Every saved version is
kept: `/contract history` (or **Contract History** in VS Code, or the Contract page) lists them, and
`/contract restore <n>` makes an earlier one active again.

## What it can say

```toml
version = 1
name = "billing-service"
description = "Boundary for AI-assisted changes to the billing service."

[scope]                          # which files may change, and how much
allowed_paths = ["src/billing/**", "tests/billing/**"]
forbidden_paths = ["**/migrations/**", "infra/**"]
max_files_changed = 20
max_added_bytes = 200_000

[commands]                       # narrows the commands AlbertCode allows
allowed = [["python", "-m", "pytest"], ["python", "-m", "ruff"]]
forbidden = [["git", "push"]]
run = [["make", "test"]]         # commands you grant beyond the built-in list

[verification]                   # evidence the change must produce
required = true
must_pass = [["python", "-m", "pytest"]]

[review]                         # the independent reviews
require_security_review = true
require_quality_review = true
block_on_severity = "blocking"   # "info", "warning" or "blocking"

[approvals]                      # human authority
require_separate_approver = true
require_admin_for_risk = ["high"]
allow_admin_override = false

[obligations]                    # engineering rules
enforce_plan_scope = true        # refuse writes to files the plan did not name
plan_must_declare_files = true   # refuse a plan that names no files
forbid_new_dependencies = true   # a newly added package fails
forbid_secret_paths = true       # never change .env, *.pem, **/.ssh/** …
forbid_committed_secrets = true  # never write a credential into a file
require_safe_migrations = false  # name migrations that lose data or take a heavy lock
forbid_public_api_breaks = false # refuse removing or reshaping what a library exports

[extensions]                     # which extra tools and skills may be switched on
allowed = ["skill.migrations", "tool.custom.tests"]
forbidden = ["tool.custom.deploy"]
allow_unlisted = false
```

Every section is optional. In paths, `**` spans folders, `*` and `?` stay within one folder, and a bare
path such as `docs` covers everything beneath it.

### How each part is used

| Section | Enforced |
|---|---|
| `[scope]` | Twice: a write outside it is refused as it happens, and the whole change is checked again before you can accept it |
| `[commands]` | `allowed` and `forbidden` only narrow the commands AlbertCode allows anyway; `run` grants extra ones. `forbidden` always wins, and every command still runs with no shell, a scrubbed environment and a time limit |
| `[verification]` | The `must_pass` commands must succeed in the isolated copy before the change can be accepted |
| `[review]` | Which reviews run, and how severe a finding must be to block the change |
| `[approvals]` | Whether the person who asked may also approve, which risk levels need an administrator, and whether a blocked change can ever be accepted with a written, recorded reason |
| `[obligations]` | Checked on every plan and every change |
| `[extensions]` | Which [tools and skills](extending.md#tools-and-skills) may be switched on in this repository |

The result of every check is part of the task's evidence: the result card lists each one as passed or
failed, with the reason.

## Direct mode and a contract

Direct mode works in your real files, outside the isolated copy the contract's checks rely on. When a
repository declares a contract and you start a direct change, AlbertCode stops and asks:

- **governed**: run it as a governed change instead, under the contract (the default);
- **disregard**: go ahead directly, only if `allow_admin_override` permits it, recorded either way;
- **cancel**.

## Allow in contract

When a skill or saved tool is not allowed by the contract, **Tools and skills** shows an **Allow in
contract** button (`/tools allow <id>` in the terminal). It shows you the exact line it will add, such
as `allowed = ["skill.style"]`, and changes the contract only when you confirm. It is offered only where
a contract already exists, never for something the contract forbids by name.

## Example: keep a team's payments code safe

```toml
version = 1
name = "shop"

[scope]
forbidden_paths = ["src/payments/**", "infra/**", "**/migrations/**"]
max_files_changed = 15

[verification]
required = true
must_pass = [["npm", "test"]]

[approvals]
require_admin_for_risk = ["high"]
```

Commit it. From now on, a plan that wants to touch `src/payments` is refused at once, a change that
fails `npm test` cannot be accepted, and a high-risk plan waits for an administrator.
