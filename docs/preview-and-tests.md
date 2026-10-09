# Preview and browser tests

Two buttons in the browser's top bar let you see your app working and prove it: **Preview** runs the
app beside the chat, and **Test** runs its browser tests.

## Preview

**Preview** starts the open repository's app if it is not running, and shows it in the side panel.

- **Starting it.** AlbertCode uses the project's dev script. When there is none, it asks for the start
  command once and remembers it for this repository. You can also type one into **Run app** on the
  repository card, or `/preview <command>` in the terminal.
- **Widths.** Desktop, tablet (834 px) and phone (390 px).
- **Status.** Whether the app is answering, on which address, with which status and how fast:
  `Running · localhost:5173 · 200 · 12 ms`.
- **Problems, said plainly.** It did not start, it stopped, it answers with an error page, or its
  output reports an error now. An error that has since been fixed is not shown as current.
  **Ask Albert to fix** puts the error into the chat; **Logs** shows the app's output.
- **Restart** and **Stop** are in the panel's header; **Open in a new tab** opens the app at its own
  address.

**A free port, every time.** Before the app starts, its usual port is checked. If another program
holds it, the app gets the next free one and the status line says so; nothing else is touched.
Commands you type are told the port too: `python -m http.server`, `manage.py runserver`, `flask run`,
`uvicorn`, `fastapi dev`, `rails server`, and `vite`, `next dev` or `astro`, directly or through
`npx`. Other programs get it in the `PORT` variable.

**Apps that forbid framing.** The preview is shown through a small proxy on your computer, so an app
that tells browsers not to show it inside another page still shows here.

## Edit by clicking

**Edit** in the Preview panel lets you change the app by clicking it.

1. Turn on **Edit**. Hovering outlines what you would choose; links and buttons do not act while
   editing. Click to choose; <kbd>Esc</kbd> lets go.
2. Change its **text**, **text colour**, **background**, **size**, **weight**, **alignment**,
   **padding** or **corners**. The app shows the change at once. **Undo** puts it back.
3. **Review change** finds where it comes from in your code:
   - **Found where it comes from**: the files and lines, and the diff. **Apply change** writes exactly
     that diff, only if the files have not changed since you reviewed them, and your dev server
     reloads.
   - **Albert will make this change**: the reason (the text is built from data, it is written in
     several places, or it is styled with utility classes). **Ask Albert** sends it as a normal task,
     with the plan and diff for you to approve.
4. **Done** turns editing off.

Direct edits work for React with TypeScript, Next.js, Vite with React, and plain HTML, CSS and
JavaScript: for text written once in the source, and for styles in plain CSS or CSS modules. For other
stacks, Albert makes every change. Each applied change is recorded in the evidence ledger.

**Example.** Click the *Sign up* button, set its background to `#16a34a` and its corners to 12 px,
then **Review change**. AlbertCode finds the one CSS rule the button's style comes from, shows the
two-line diff, and **Apply change** writes it.

## Browser tests

**Test** in the top bar checks your app the way a person uses it: pages, forms, saved data and
sign-in. The tests are [Playwright](https://playwright.dev) files in your repository's `e2e/` folder,
so you can read them, change them, run them yourself with `npx playwright test`, and commit them.

1. **Write browser tests** asks Albert for them as a normal task, through the usual plan and diff
   approvals: one file per journey people take through the app, a `playwright.config.ts` that runs
   against the preview, and `@playwright/test` in `package.json`.
2. **Install** runs your package manager's install, so the test runner is there.
3. **A browser.** A Chrome, Edge or Chromium already on your computer is used. Only when there is none
   does the panel offer Playwright's Chromium (about 150 MB), downloaded when you click.
4. **Run tests** starts the app if needed, runs every test, and shows what passed and what failed.
   Each failure has its error, its place in the test, its screenshot and its trace, with **Fix with
   Albert**, **Open the test** and **Run again** (just that file).

Results come from Playwright's own report: a run that leaves no report is shown as not having run,
never as a pass. Installing, downloading a browser and running tests are each your click, and each is
recorded in the evidence ledger.

**Fix with Albert** on a failing test starts a chat of its own with the test, its error, its screenshot
and the command to run it, filed under that test in the sidebar. Fixing the same test again joins it.

### Tests that check requirements

Title a test with a requirement's number in brackets and it becomes that requirement's evidence on the
[Requirements page](requirements.md):

```ts
import { test, expect } from '@playwright/test';

test('[R1] add a note and see it in the list', async ({ page }) => {
  await page.goto('/');
  await page.getByPlaceholder('Write a note').fill('Buy milk');
  await page.getByRole('button', { name: 'Add' }).click();
  await expect(page.getByRole('listitem')).toContainText('Buy milk');
});
```

The config reads the app's address from `BASE_URL`, which AlbertCode sets to the preview.
