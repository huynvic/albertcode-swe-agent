# Changelog

Release notes for AlbertCode SWE Agent, newest first. Each release's installers and checksums are
on the [releases page](https://github.com/huynvic/albertcode-swe-agent/releases).

## 1.49.1 — 2026-10-09

- **Security fix.** The one address **Start all** gives your app (`localhost:4400`) kept cookies, so a
  second browser could be signed in as the first person. It now keeps none: each browser keeps its
  own. Affects 1.47.0 to 1.49.0.
- **Started again in its place.** A part that is up but not working, whose services moved, or whose
  code changed and does not reload by itself (a worker, say), is started again where it runs, never as
  a second copy.
- **Every declared package checked** before a Python part starts, each missing one listed under
  **Install packages**.
- **Redis with nothing to connect.** In Development, with `redis-server` installed, AlbertCode runs its
  own Redis and its answer proves the step.
- **A service that does not answer is yours to start.** Verification names it and what it said, and
  asks you to start it or change its connection; nothing is sent to Albert to repair. A browser the
  tests could not start is something to install.
- **Clearer evidence.** Each connected service is named with what it answered.
- **The map reads more of your code:** routes under a router's prefix, endpoints under a parameter,
  services in variables, packages and setup files, and sign-in token libraries. A line to a later step
  no longer holds back what is verified before it.
- **Names on lines never overlap,** and the line between two neighbours keeps its own name.

## 1.49.0 — 2026-10-08

- **Step by step, the app first.** The System page's **Build** stage starts with **The app runs**: each
  part started and answering, nothing else yet. Then each service your features use is added on its
  own, through an adapter, and then the features connect them. Each step is proven running before the
  next starts.
- **Like a senior full-stack engineer.** Albert follows each framework's own way, builds only what the
  step needs and builds it properly, decides and keeps moving, tests as it goes, and says what it
  built. A repair finds the cause in the evidence first and fixes it there.
- **Quicker first steps.** The app and its services are proven by running them, with no browser test
  runner to install yet. If something later breaks an earlier step, that step is the one repaired.
- **No loops over missing packages.** **Verify** lists each package your app still needs with its own
  **Install** button, and nothing is sent to Albert to fix. A build queue pauses for it.
- **System in the top bar,** next to **Terminal**. The chat beside the map stays when you come back,
  the **System** button shows when Albert is working, and each piece of work keeps one chat.
- **See where Albert is.** The map shows the part Albert is writing now, and the build queue says how
  far it is.
- **Fixed:** a front end no longer looks installed because of the browser test runner at the root of
  your repository, and a package added after the last install is found missing.

## 1.48.0 — 2026-10-08

- **Albert recommends, you decide.** On the System page's **Plan** stage, each recommendation says
  whether it is required, recommended or optional, why and what it changes. **Accept**, **Modify**,
  **Defer** or **Reject** it, or ask Albert to **Explain** it. Your decisions are kept and Albert
  follows them: it never adds or swaps a service you did not choose.
- **Build several slices at once.** Tick slices, or **Select all**, then **Build selected** or **Build
  all**: they are built in order, each verified before the next, even if you close the page, with
  **Pause**, **Resume** and **Cancel**. Nothing is ever started twice.
- **Every part's status, on evidence.** Each part and connection shows Planned, Building, Built,
  Connected, Testing, Verified or Failed. Only Verified is green, and only on your code as it is now.
- **Five stages.** **Design**, **Plan**, **Build**, **Verify** and **Operate**, each with how far it is.
- **Release what was verified.** A release waits until your app is verified end to end on the exact
  code released. Verification runs in Development, never against your live data.
- **Fixed:** a service added for a feature is now used by it; building several slices no longer
  stops when an earlier slice needs verifying again.

- **Build one working slice at a time.** The System page's **Build** stage turns your design into a plan:
  what the product is for, its requirements and journeys, then slices, each one thing a person can do,
  built from the screen to the data and back. The next slice starts only when this one is proven
  running.
- **Proven, not assumed.** Parts move from Planned to Built, Connected and Verified only on
  evidence. **Verify** starts your app, checks every part and connected service, and walks every
  journey in a browser; a slice that passes is kept as a checkpoint, and one that fails gets
  **Repair**, then **Roll back** if it still fails.
- **Start all.** One button runs every part of your app on your computer, in order, each on its own
  port, wired to the others and reached at one address. **Operate** → **Run** shows each part's state and
  log, with Stop, Restart, Install packages and Fix with Albert.
- **Parts of your own.** Add your own front end, service, worker or data store, and say how it runs.
- **Only the folder you opened.** The System page and Architecture read only the files in the open
  folder as they are now.
- **Chats kept together.** Chats about the same slice, part, test, requirement or release are grouped
  in the sidebar.
- **Documentation.** A complete guide with examples for every command, page and button, inside
  AlbertCode (**⋮ → Documentation**) and in [docs](docs/README.md).
- **Fixed:** a build could wait on a step without saying why; the System page now fills the window
  beside the chat.

- **Fix every problem with Albert.** The **Verify** stage lists every open problem from development,
  testing and your running environments, each from a real check or test with its evidence. Fix one,
  or all of them as one plan you approve.
- **Release only after verification.** **Release** checks an environment (code committed, services
  working now, tests, requirements and contracts holding) and records the commit as its release only
  when nothing fails, tagged locally. Your own pipeline deploys it.
- **Observe, repair, roll back.** Each environment keeps its recent checks; **Fix with Albert** sends
  what failed and what changed since the last release; **Roll back to this** hands Albert the exact
  change back to a release, checked first, as a plan you approve.
- **Security update** for the sign-in library, and fixes: a harmless browser notice no longer shows
  as an error or re-enables Send while Albert is working.

- **Environments.** Development, Staging and Production, each with its own connections, keys and
  statuses on the same System map.
- **Variables instead of keys.** Type `${NAME}` when connecting: only the name is kept, and the value
  is read from the terminal AlbertCode was started in each time it checks. It never appears in a
  result, the page or a file, and AlbertCode's own settings can never be used.
- **Contracts on connections.** Say what a connection carries (endpoints, tables, topics) and see
  where the code at each end has it, or that it is not there yet. Building makes every item.
- **Design your system, then have Albert build it.** The System map is a design canvas: lanes,
  zoom, **Fit** and **Tidy**, and connections you draw by dragging a box's dot onto another box.
  What you design is shown as planned until your code has it. **Build this system** hands the design
  to Albert as a plan you approve; **Build what changed** only what you added since.
- **Backbones.** Start from one of 21 (SaaS, enterprise web app, AI application, e-commerce,
  internal business system, CRM and more), say what your product is, and its parts, connections and
  requirements go on the map. Save any map as your own backbone.
- **Plan the features.** Your model lists the product's features, which parts each is built on and
  what is missing. Missing services are suggested on the map and added only when you say so. The
  **Plan** stage shows each feature's requirement, parts, code and tests.
- **Starting after an update.** The first start after installing could be reported as failing while
  AlbertCode was still starting; it now waits for it.
- **Visual editing on Windows.** Applying a change while your app's server had the file open could
  fail with "Access is denied". It now waits a moment and tries again, and never leaves half a change.
- **System.** A page with every part of your app and every service it relies on, on one map.
  It starts from your code and grows from a library of 109 services, each with its logo, what it is,
  how it is checked and what Albert can do with it. Drag boxes to arrange them, drag services in
  from the library, and select a line to see which file shows that connection.
- **Connected means checked.** Give a service its address and key and AlbertCode checks it straight
  away, read-only. A service is marked working only when the check signed in; otherwise it says
  why. Keys stay in your computer's key store. **Check everything** checks them all at once.
- **Albert beside every box.** Ask why something fails and your model answers from the last check.
  **Fix with Albert**, **Wire it into the app** and each service's actions run in a panel beside the
  map, where you watch the work and approve the plan and the change.
- **Updating on Windows while AlbertCode is open.** If AlbertCode was still running somewhere
  (another terminal, VS Code, or its background service), installing a new version could stop with
  "Access is denied (os error 5)". The installer now lists the AlbertCode programs still running,
  closes them after you say yes, and then installs.
- **Your app shows in the preview.** Apps that tell browsers not to show them inside another page
  (Django does by default, as do many security setups) opened in their own tab but showed
  "localhost refused to connect" in the preview. They now show in the preview too.
- **Never a busy port.** Before your app starts, AlbertCode checks its port, and when something else
  is using it, gives the app the next free one, now also when you typed the start command yourself
  (`python -m http.server`, `flask run`, `uvicorn`, `npx vite` and others).
- **Visual editing.** Click anything in the preview and change its text, colours, size, weight,
  alignment, padding or corners, and see it at once. **Review change** finds the one place in your
  code it belongs and shows the diff to approve; when there is no single safe place, AlbertCode
  says why and Albert makes the change as a task. Direct edits work for React with TypeScript,
  Next.js, Vite with React, and plain HTML, CSS and JavaScript.
- **Architecture.** See what your app is made of and how the parts connect, drawn from its own
  files: what people use, what runs, and what it relies on. Every box and line comes from a file
  in your repository; select a part to see which, with its routes, pages and data models.
- **Requirements.** Turn a specification into a checklist that proves itself. Your model drafts
  the list from your specification; you edit and save it, and it is kept in your repository. Each
  requirement shows Complete, Partial, Failed or Missing, worked out from your browser tests and
  tasks, with the reason and the evidence, and one click to build it, fix it or add a test.
- **Browser tests.** **Test** in the top bar checks your app the way people use it, with Playwright
  tests kept in your repository's `e2e/` folder. Albert writes them as a normal task (you approve
  the plan and the diff); one click installs the runner and runs them against your app. A failure
  shows its error, a screenshot and a trace, and **Fix with Albert** starts a task to fix it. An
  installed Chrome, Edge or Chromium is used; a browser is downloaded only if there is none, and
  only when you ask.
- **Preview, beside the chat.** **Preview** starts your app and shows it at desktop, tablet or phone
  width, says whether it is answering, and says plainly when something is wrong, with **Ask Albert
  to fix**.
- **A task board.** **Tasks** shows every task in five columns, Planned, Active, Blocked, Verifying
  and Completed, with what each one is waiting for.
- **A terminal inside the browser**, beside the chat or under it, with tabs, in your repository.
- **Governed changes.** AlbertCode plans a change, you approve the plan, it builds the change in an
  isolated copy of your repository, runs your own tests, reviews the result, and shows you the diff.
  Your files change only when you accept it.
- **Three interfaces.** The terminal (`albertcode`), the browser (`albertcode --ui`) and VS Code,
  all driving the same local service. Three modes: Governed, Direct and Ask.
- **A Files panel in the browser**: new file and folder, rename, duplicate, copy, cut and paste,
  copy a path, and move to the Trash, inside the open repository only.
- **Any model**: hosted providers, any compatible API service, or a model on your own machine.
- **Private by default.** Keys are kept by your system's own protection (the macOS Keychain,
  Windows data protection or your Linux keyring); only AlbertCode itself can use its local service;
  no telemetry and no account. See the [security model](docs/security.md).
- **Installers for Windows, macOS and Linux**, each checked against `SHA256SUMS`, and
  `albertcode uninstall` to remove AlbertCode with nothing downloaded.
