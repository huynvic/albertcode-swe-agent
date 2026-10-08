# Requirements

**Requirements**, in the browser's **⋮** menu, keeps what your app must do as a checklist, and shows
where each item stands from evidence: the browser tests that passed or failed, and the tasks that built
it. Nothing is marked done because someone said so.

## Write the list

1. **Draft requirements**: paste a specification (a brief, a list of features, a ticket). With a model
   connected, AlbertCode drafts one checkable requirement per behaviour; without one, it uses the
   specification's own bullets and sentences.
2. Or choose **Write them myself**.
3. Edit, reorder, add and remove, then **Save requirements**.

Each requirement has a title (up to 160 characters) and an optional detail; a list holds up to 200.
They are numbered R1, R2, R3…, and each keeps its number when you edit the list; new ones are numbered
after the highest. The list is kept in your repository, in `.albertcode/requirements.json`, so it is
versioned and reviewed with the code it describes:

```json
{
  "version": 1,
  "spec": "A notes app: write a short note and keep it in a list.",
  "requirements": [
    {"id": "R1", "title": "Add a note and see it in the list", "detail": ""},
    {"id": "R2", "title": "Notes are kept after a reload", "detail": "Stored in SQLite"}
  ]
}
```

You can edit the file by hand too; the page reads it as it is.

## Where each one stands

| Status | When |
|---|---|
| **Complete** | It has browser tests, and all of them passed in the latest run |
| **Partial** | Some of its tests passed, or it was built but no test checks it yet |
| **Failed** | One of its tests failed, or the task that built it failed |
| **Missing** | Nothing has built it, and no test has passed for it |

Each row says why, and opens to its **Evidence**: the tests (with their file and line) and the tasks
behind it, each one click away.

### How evidence finds its requirement

- **A browser test** belongs to a requirement when its title starts with the number in brackets:

  ```ts
  test('[R3] notes can be searched', async ({ page }) => { … });
  ```

- **A task** belongs to it when its request says `(requirement R3)`.

The buttons below word their requests that way for you, and so does the
[System page](system.md#build-one-working-slice-at-a-time): each slice's browser test is titled with
its requirement.

## Move one forward

| Button | For | What it does |
|---|---|---|
| **Build with Albert** | A missing requirement | Asks Albert to build it, with a browser test titled `[R…]` |
| **Fix with Albert** | A failed requirement | Asks Albert to find the cause and fix it |
| **Add a test** | A partial requirement | Asks Albert for the browser test that checks it |
| **Check now** | The whole list | Runs the browser tests again |

Each starts a chat of its own on the Chat page, filed under that requirement in the sidebar (see
[Chats about one thing](chat.md#chats-about-one-thing)), and goes through the usual approvals.

## Example

1. Paste: *"Users sign up with email and password. They can reset a forgotten password by email. An
   admin can disable a user."* → **Draft requirements**.
2. AlbertCode drafts R1 *Sign up with email and password*, R2 *Reset a forgotten password by email*,
   R3 *An admin can disable a user*. Edit the wording, **Save requirements**.
3. All three are **Missing**. Press **Build with Albert** on R1, approve the plan, accept the diff.
4. **Check now**: the new `[R1] …` test passes, and R1 is **Complete**.
