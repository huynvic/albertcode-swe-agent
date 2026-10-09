# The System page

**System**, in the browser's top bar next to **Terminal**, is where you design a whole app, connect the services it
relies on, have Albert build it step by step (the app first, then each service, then the features that
connect them), run every part of it, fix what fails and release it. Everything on the page comes from evidence: your repository's files, checks that really
signed in, and tests that really ran.

```text
 Describe ─▶ Plan the features ─▶ The app ─▶ Each service ─▶ Each feature ─▶ End to end ─▶ Release
  (what)      (map + journeys)    (runs)     (one by one)   (connects them)  (together)   (checks)
```

Albert builds each step and AlbertCode verifies it, running, before the next one starts.

This guide goes through the page from top to bottom, then walks through
[three examples](#examples).

## The page at a glance

| Area | What it holds |
|---|---|
| **Environment tabs** | Development, and any of Staging and Production you add. Each has its own connections, keys, checks and releases on the same map |
| **The bar** | How many parts are working, then **Read again**, **Check everything**, **N to fix** and **Release**. A part counts as working when its check passes or, in Development while **Start all** runs it, when the runtime proves it up |
| **What you're building** | Your product in one sentence (**Describe it** / **Edit**), how many parts and connections are built, and **Backbones**, **Add service**, **Plan features**, **Start all** and the next build step (such as **Build: Add a note**) |
| **The map** | Every part of the app in lanes, with the lines between them. On a narrow window, a list |
| **The stages** | Under what you're building: **Design**, **Plan**, **Build**, **Verify** and **Operate**, each with how far it is. ✓ marks a stage that is done; the one to do now is outlined. Select one to open it |
| **The side panel** | The same five stages: **Design** (the **Parts** and the **Library**), **Plan**, **Build**, **Verify** and **Operate** (**Run** and **Release**) |

When you ask Albert something from this page, its chat opens in a panel beside the map, so you see
the work and approve its plan and diff there. **Open in Chat** moves it to the chat page; closing the
panel with **✕** leaves the work running, and **Albert's work** in the bar brings it back. Go to another
page and come back, and the panel is there again as you left it.

**Albert at work.** While Albert works, the panel's heading says *Working on …* and its mark breathes;
when its plan, a write or its change waits for you it says *Waiting for you*. **Albert's work** pulses
while the panel is hidden, and a dot on **System** in the top bar says the same from any page.

**One chat per piece of work.** A button that asks Albert about something a chat is already working on,
or waiting on you for, opens that chat instead of starting another: pressing **Build** again, or coming
back from the chat page and pressing it, never makes a second chat or a second task. While Albert works
on a slice, its button says **Albert is working on it · Open** (or **Waiting for you · Open**), and the
bar's next step says **Building: …**; when the work is over, its buttons come back. A button whose own
work is under way keeps a spinner, such as **Asking Albert…** or **Verifying…**, until it is done.

### The five stages

| Stage | What you do there | Done when |
|---|---|---|
| **Design** | Lay the app out on the map: parts from the **Library**, connections, a selected part's details | You said what you're building, and the map has parts |
| **Plan** | Turn what you're building into features, and decide Albert's recommendations | Every feature has its requirement, journey and parts |
| **Build** | Build the slices, one at a time or several in a [build queue](#build-several-slices-build-selected-build-all) | Every slice is in the code |
| **Verify** | See what is verified, verify the next slice, and fix every open problem | Every journey passes together, end to end |
| **Operate** | **Run** every part at one address; **Release** an environment | The environment is released |

Each says, in a few words, where it stands: *2 of 4 built*, *1 of 4 verified*, *Running · 3/3*. A stage
remembers where you left it: **Operate** opens on **Release** again if that is where you were.

## The map

The map starts from your repository: the web app, the API, background jobs, the database, the cache,
payments, email and the rest appear on their own, read from the same files the
[Architecture page](architecture.md) reads. It only ever reads the folder open now, as it is now.

**Lanes.** From left to right: what people use, what runs, your data, and outside services.

**Each box** shows the part's name, what it is, and how it stands:

| Look | Meaning |
|---|---|
| Solid | In your code |
| Dashed, *planned* | On the map but not in your code yet |
| Dotted, *suggested* | Something the feature plan says is missing; press **Add** to put it on the map |
| Green / amber / red dot | Its last check: working, answers but sign-in not proven, failing |
| A chip with a port | It is running now (see [Run every part](#run-every-part)) |
| A tick or a cross | Albert finished, or hit a problem, on this part in the current chat |

**How your code shows a part.** A dashed box turns solid when your code has what it describes: a
package that reaches it (`@okta/okta-react`, `stripe`), the variable it is configured by, named in a
`.env.example` (names written for the browser, such as `NEXT_PUBLIC_…` or `VITE_…`, count too), the
image it runs from in `docker-compose.yml`, or the file that sets it up (`.github/workflows/ci.yml`
for GitHub Actions, `vercel.json` for Vercel, a `Dockerfile` for Docker). Each build request names
the variable or file to use, so a box Albert builds turns solid. An API that only sends jobs to a
Celery worker stays the API: the worker is the folder whose code defines the tasks.

For example, with this `api/.env.example` the Company sign-in (Okta), Error reports (Sentry) and
Monitoring (Datadog) boxes turn solid:

```text
OKTA_ISSUER=https://your-company.okta.com/oauth2/default
SENTRY_DSN=
DD_API_KEY=
```

**Moving around.** Drag a box to arrange the map; it stays where you put it, for this repository on
this computer. Drag empty space to move. <kbd>Ctrl</kbd>/<kbd>⌘</kbd> with the mouse wheel, or **−**
and **+**, zooms. **Fit** shows everything; **Tidy** lines the boxes up in their lanes. **List** shows
every part and how it stands; **Library** opens the library.

**Connecting boxes.** Drag a box's dot onto another box, or click the dot and then the other box.
Select a line to see the file that shows the connection, its [contract](#contracts-on-connections),
**Go to** either end, or **Remove this connection**. Each line is named by what it carries, such as
*HTTP*, *SQL* or *Sign-in*, where the name covers no box and no other name; when a busy corner leaves
no room for it, point at the line or select it to read its name.

**Read again** reads the repository afresh, for example after you changed files outside AlbertCode.

## The library

**Add service** (or **Library**) opens 113 services in 15 groups:

| Group | Services |
|---|---|
| Your app | Next.js, Vite + React, FastAPI, Django, Express, Flask, Nuxt, Nginx |
| Databases | PostgreSQL, MySQL, MariaDB, SQLite, MongoDB, CockroachDB, ClickHouse, Elasticsearch, Supabase, Neon, PlanetScale, Firebase, Turso |
| Cache & queues | Redis, Upstash, RabbitMQ, Kafka, NATS, Celery |
| Sign-in | Auth0, Clerk, Okta, Google sign-in, GitHub sign-in, Sign in with Apple, Keycloak |
| Payments | Stripe, PayPal, Square, Paddle, Lemon Squeezy, Razorpay, Adyen, Braintree |
| Email & messaging | Email (SMTP), Mailgun, Resend, Brevo, Mailchimp, Discord, Telegram, WhatsApp Business, Pusher |
| Storage | S3-compatible storage, Cloudflare R2, MinIO, Backblaze B2, Google Cloud Storage, Cloudinary |
| Deploy & hosting | Vercel, Netlify, Cloudflare Workers, Render, Railway, Fly.io, Google Cloud Run, DigitalOcean, Hetzner, Kubernetes, Docker, GitHub Actions |
| Monitoring | Sentry, Datadog, Grafana, Prometheus, PagerDuty, New Relic, Better Stack, OpenTelemetry, Uptime Kuma, Rollbar |
| Analytics | PostHog, Google Analytics, Mixpanel, Plausible, Hotjar |
| Search | Algolia, Meilisearch |
| AI services | Model API, Local model server, pgvector, Qdrant, Milvus |
| Content | Notion, Contentful, Sanity, Strapi, WordPress, Shopify, Airtable, Google Sheets |
| Developer tools | GitHub, GitLab, Bitbucket, Jira, Linear, Figma |
| Your own | Your own front end, Your own service, Your own worker, Your own data store, REST API (OpenAPI), GraphQL API, MCP server, Webhook |

Search by name, filter by group, and select one to read what it is, **How AlbertCode checks it**,
**What Albert can do with it** (each action marked *reads only* or *changes something*) and **How it
connects**. Then drag it onto the map, or press **Add to the map**.

For parts that no entry describes, see [Your own parts](#your-own-parts).

## Details: one part

Select a box to see its details (on the **Design** stage):

- **Rename** it.
- **Why it is on the map**: the file that put it there, or *Planned: not in the code yet*.
- **Connected to**: its lines, each with the reason.
- **What the check saw**, and when.
- **How it runs**, for the parts of your app (see [Run settings](#run-settings)).
- **Connect** / **Change connection**, **Forget the connection**.
- **Ask Albert about** it: a question box answered from the part's last check and where your code
  uses it.
- **Fix with Albert** (when its check fails) and **Wire it into the app** (for a service you added):
  each starts a plan for your approval, beside the map.
- **What Albert can do with it**: the service's own actions, each with **Ask Albert**. An action that
  only reads is asked straight away; one that changes something starts a plan.
- **Remove from the map**.

Every chat started here is filed under this part in the sidebar: see
[Chats about one thing](chat.md#chats-about-one-thing).

## Connecting a service

Select a box and press **Connect**, then give what it asks for: an address, a user, a key. AlbertCode
keeps them in your system's key store and checks the service at once. Leave a key empty later to keep
the saved one.

**Connected means checked.** The check is read-only: it signs in and asks something harmless, and
never writes or sends anything.

| Status | Meaning |
|---|---|
| **Working** | The check signed in and a read-only request answered |
| **Answers, sign-in not proven** | It answered, but the sign-in could not be shown to work (a service that needs no key, or a sign-in the check does not speak) |
| **Failing** | With the reason, such as the password not being accepted |
| **Not connected**, **Not checked** | Nothing is claimed |

Seven services need a sign-in in your browser, such as Google Analytics: they are checked with Albert
instead. **Check everything** checks every connected service at once.

Keys stay in your system's key store: never in your repository, a log, the page or a model's view.

### Variables instead of keys

When connecting, tick **Read them from environment variables** and type `${NAME}` in any field
(capital letters, digits and `_`). AlbertCode keeps only the name and reads the value each time it
checks, from the terminal it was started in, so set the variable there before `albertcode --ui`:

```bash
export SHOP_DB_PASSWORD="…"
albertcode --ui
```

Then connect PostgreSQL with **Address** `postgres://shop@shop-db:5432/shop` and **Password**
`${SHOP_DB_PASSWORD}`. A whole address can come from a variable too, such as `${SHOP_DATABASE_URL}`.

If it is not set, the check says which variable is missing and sends nothing. Names AlbertCode uses
for itself (such as `DATABASE_URL`, and names starting `ALBERTCODE_`) cannot be used: give the
service its own, such as `SHOP_DATABASE_URL`.

## Environments

The tabs at the top are **Development** and any of **Staging** and **Production** you add with **+**.
Each environment has its own connections, keys and statuses on the same map, and **Check everything**,
**Verify** and **Release** work on the one shown. **Remove** an environment to forget its connections and
keys; Development always stays.

In **Production**, checks only read, and Albert never sees its keys: build and fix changes still go
through your approval and your own release.

## Contracts on connections

Select a line between two parts and add what it carries:

| Kind | Example |
|---|---|
| **Endpoint** | `GET /orders/{id}` |
| **Table** | `orders` |
| **Topic or queue** | `order-paid` |
| **Other** | Anything else the two ends must agree on |

Each item is looked for in the code under each part's own folder, and shows *in the code at both
ends*, *at one end only*, *not in the code yet* or *outside this repository*, with the files and
lines to open. An endpoint counts only where its method is next to its path: where it is served, and
where it is called unless it is a `GET`. Build requests include every contract, and items not in the
code yet appear on the **Verify** stage.

## Backbones

**Backbones** opens 21 designs to start from:

| | | |
|---|---|---|
| SaaS Backbone | Enterprise Web App | AI Application |
| E-commerce Platform | Internal Business System | CRM |
| Marketplace | Bookings and appointments | Blog and content site |
| Mobile app backend | Real-time chat | Project management |
| Online courses | Helpdesk and support tickets | Analytics pipeline |
| Social network | Food delivery | Event ticketing |
| Inventory and orders | Newsletter and email marketing | Job board |

Pick one, say what your product is ("a CRM for a legal practice"), and choose whether to add its
requirements. Its parts, connections and requirements go on the map, adapted to your product by your
model if one is connected. Parts already on the map are reused.

**Save this map as a backbone** keeps your current design, with how many of its parts were checked and
working, under *Your backbones*; you can delete it there.

## Plan: the product and its features

The **Plan** stage turns what you're building into features:

1. **Describe your product**, in a sentence or two: *"A notes app: write a short note and keep it in a
   list"*.
2. Press **Plan the features**. Your model lists the features, the [requirement](requirements.md) each
   delivers, the parts each uses, **the journey** a person takes through it (the steps a browser test
   will walk) and **how to tell it works**.
3. Anything the map is missing appears dotted as *suggested*, and as a recommendation (below): **Add**
   puts it on the map, joined to the part that needs it, and the feature that needed it is built on it.
   **×** rejects it.

For each feature the stage shows its requirement's status, its parts, where the code is, and how many of
its tests passed in the latest run. **Describe it again** starts over.

### Recommendations: Albert recommends, you decide

The **Plan** stage opens with Albert's recommendations, and the bar shows how many are waiting for you
(*3 suggestions*). Nothing changes until you accept one. Each card says:

| On the card | Meaning |
|---|---|
| **Required**, **Recommended** or **Optional** | Required: a feature cannot work, or would be unsafe, without it. Required ones come first |
| The area | Capability, security, reliability, correctness, testing, performance, scalability, cost, compatibility or approach |
| Where it comes from | **From the plan** (what a planned feature needs), **Albert's review** of the design, or **From a check** of the map, the code and what ran |
| Why, and what changes | Why it matters here, and exactly what accepting it does |

| Button | What it does |
|---|---|
| **Accept** | Applies it: adds the part, draws the line, lists the endpoints in the contract, or, for a change to your code, asks Albert as a plan you approve |
| **Modify** | Change it first, then **Accept with these changes**: another provider of the same kind, only some of the endpoints, or other words for Albert's advice |
| **Defer** | Puts it off: it moves to **Later**, where **Decide now** brings it back |
| **Reject** | Changes nothing. A required one first tells you what rejecting it means. Albert is told not to do it |
| **Explain** | Shows the benefits, trade-offs, risks, what it depends on, the alternatives, what rejecting it would mean, and what it rests on |

Your decisions are kept with the map, for every session. **Decided** lists them, each with
**Reconsider**. A rejected recommendation is not offered again unless what it rests on changes (for
example, another feature needs it too); it then says *Offered again*. Every request to Albert (building a
slice, the whole map, a repair, the next plan) carries your decisions, and Albert may use only the parts
and providers on your map: it never adds one you did not choose, or swaps one you did. A slice that
needs a service you rejected says so on the **Build** stage, with what you can do instead.

What the checks look for:

| Recommendation | When |
|---|---|
| Add a service | A planned feature needs a capability no part provides |
| Add or connect a broker | A Celery worker has no Redis or RabbitMQ joined to it |
| Connect a service | A built database or service cannot be checked, so the slices through it cannot be verified |
| Give a part a health route | **Start all** shows it *Running* but nothing proves it works |
| Add endpoints to a contract | The plan's features call endpoints the line's contract does not list |
| Stop keeping a key file in Git | A file that looks like it holds keys (`.env`, `*.pem`…) is tracked by Git: read by name only, never opened. Accepting shows the steps, which are yours to take |
| Take a part off the map | A planned part no feature uses (never one with code) |

**Albert's review** (with **Plan the features**) adds up to six pieces of advice about security,
performance, scalability, cost, compatibility and approach, each with its reason; accepted advice is
followed in every build.

## Build: one working slice at a time

The **Build** stage is the Build Manifest: what to build, in which order, and how far the evidence takes
each part. Albert builds nothing until the product, its requirements and its journeys are known.

### From what it is for to its release

| Step | Done when |
|---|---|
| 1. Product intent | You said what you are building |
| 2. Requirements | Each feature delivers a requirement |
| 3. User journeys | Each feature has a journey a test can walk |
| 4. Architecture | Each feature is on parts of the map |
| 5. Build manifest | The map is made into what to build, run and prove |
| 6. First slice | The app runs, each service is added, and the smallest real flow is running and proven |
| 7. Features | Every other feature is proven running |
| 8. Integration | Each outside service is made real and checked |
| 9. End to end | Every journey passes together |
| 10. Release | Released from this environment |

A step counts as done only when every step before it is. The button in the bar always offers the next
one: **Describe the product**, **Plan the features**, **Build: …**, **Verify: …**, **Repair: …** and
so on. While a [build queue](#build-several-slices-build-selected-build-all) works, it reads
**Building · 1 of 3** and opens the queue.

### Slices

Albert builds the app step by step, never all at once, and each step is proven running before the next
one starts:

1. **The app** first: each part started and answering its health route, and the front end reaching the
   API. No database, no sign-in and no features yet.
2. Then each **Service** the features use, one at a time, through an adapter: the database first (its
   migration set up, with no tables until a feature needs one), then each outside service, with a
   stand-in until its own slice makes the real one work.
3. Then the features, which connect them: each is one thing a person can do, built from the screen
   through each part it needs to the data and back, with a browser test that walks its journey.
4. Last, each outside service made real, and every journey together.

| Kind | What it is |
|---|---|
| **The app** | The app itself, running: each part answers, and the front end reaches the API. Nothing else yet |
| **Service** | One service the app uses (a database, sign-in…), added through its adapter. A database must answer AlbertCode's check; a Redis the runtime runs itself in Development is proven by its answer, with nothing to connect; an outside service answers through its stand-in |
| **First feature** | The smallest real flow the product has, on the app and its services |
| **Feature** | Each other feature, in order |
| **Outside service** | Each outside service (payments, email…) made real: until then the app uses a stand-in |
| **End to end** | Every journey, passing together |

The slice that is next shows its journey and one button:

| Button | What it does |
|---|---|
| **Build** | Albert builds this slice, and only this slice, on the ones already in place. It starts as a plan you approve |
| **Verify** | AlbertCode starts the app and proves the slice works (see below) |
| **Verify again** | Built, but something it needs is not installed yet: press **Install** on each one listed, then verify again. Nothing is repaired for this |
| **Repair** | It failed its verification: Albert gets the evidence and fixes it (at most 3 attempts) |
| **Roll back** | It failed three repairs: Albert puts the code back as it was at the last checkpoint, as a change you approve. Then build it again |
| **Connect** | Built: connect its services on the map so AlbertCode can check them, then verify |
| **Plan** | It needs a part the map does not have yet: add it from the Plan |

**What Albert is asked.** Each build request asks for one step, and says what is not part of it. Every
request names the product and every part the slice goes through: its folder, how it starts, its port,
its health route and the environment variables it is configured by (names only).

- **The app**: each part's skeleton in the framework's own layout, starting and answering its health
  route, with a test for it, and the front end reaching the API. *Nothing else yet.*
- **A service**: that one service added to the part that uses it, through an adapter configured by its
  environment variables, with a stand-in for tests. A database with tables (PostgreSQL, MySQL, SQLite
  and the like) also gets its migration set up, with no tables until a feature needs one; a cache or a
  queue such as Redis has none to set up. *No feature uses it yet.*
- **A feature**: the requirement, the journey, how to tell it works, its endpoints and the data it
  keeps (with a migration), built on the parts already in place, and a browser test titled `[R1] …`
  that walks the journey.

A repair request adds what failed, each failed journey's error, how each part was run, and the last
lines each failing part printed, and asks Albert to find each failure's cause in that evidence before
changing anything, and to fix it at its source without rewriting what works.

**One part at a time.** Within a step, the request gives the order: the part everything else stands on
first (the API, with its data and its adapters), finished with its own tests and health route; then the
parts that use it (the front end); then the connections between them; and, in a feature, last the
browser test for the journey. On the map, only the part or connection Albert is writing now shows
**Building**; a part it finished shows a ✓, and Albert moves to the next.

**Like a senior full-stack engineer.** Every request asks Albert to follow each framework's own
conventions; to build only what the step needs, and to build it properly; to decide and keep moving
rather than ask what the request already answers; to test as it builds; to finish and check each part
before the next; and to end by saying what it built.

**Packages are yours to install.** Albert does not install packages or run project generators
(`npm install`, `pip install`, `npx create-…`): it writes each part by hand and lists what it needs in
the part's own dependency file (`package.json`, `requirements.txt` or `pyproject.toml`), with the browser
test runner in the `package.json` at the repository root. A test, build or type check that needs
packages that are not installed is not run, and is shown as *Not run*, with why; it is never sent back to
Albert as a defect to repair. You install the packages with one click each when the slice is verified
(see [Verification](#verification)). In an empty folder the request says there is no code yet, so Albert
plans the files from the request instead of looking for code that is not there.

### Build several slices: Build selected, Build all

You need not press each slice's button in turn. Above the slices, **Build several** builds the ones you
choose one after another, in order, and verifies each before the next starts:

1. Tick the slices to build (each slice that is not verified has a tick box), or tick **Select all**.
2. Choose **How Albert works**, as in the chat:
   - **Governed**: you approve Albert's plan, then the change, for each slice.
   - **Direct — ask each write**: Albert works in your files, and every write waits for your OK.
   - **Direct — auto-approve**: Albert works in your files, and writes land without asking. Git is the undo.
3. Leave **Repair a failed verification automatically, up to 3 times** ticked, or untick it to decide
   each repair yourself.
4. Press **Build selected** or **Build all**.

A slice is built on the ones before it, so choosing slice 3 alone also queues slices 1 and 2 if they
are not verified; they say *Needed first*. The model chosen in the chat builds each one.

**The queue.** While it works, the **Build** stage shows **Build queue · 1 of 3 done**, what is happening now,
and **Open** on a slice waiting for you, which opens its chat where you approve the plan, a write or the
change. The bar's next step reads **Building · 1 of 3**. Each slice in the queue moves through:

| State | Meaning |
|---|---|
| **Queued** | Waiting its turn |
| **Processing** | Albert is planning or writing it, and the line under the queue says how far: *Albert is planning it: 6 steps so far*, *Albert is writing it: 12 files written, 2 commands run*, *Albert's change is being reviewed* |
| **Waiting for you** | A plan, a write or a change waits for your approval: press **Open** |
| **Verifying** | AlbertCode is starting the app and walking the slice's journeys |
| **Completed** | It passed its verification; the slice itself then shows **Verified**, from that evidence |
| **Failed** | It stopped; the queue says why |
| **Cancelled** | You cancelled the queue before it was built |

A slice turns green only when its verification passes. A queue saying *Completed* never makes a slice
green: if the code changes afterwards, the slice is no longer verified.

| Button | What it does |
|---|---|
| **Pause** | The step under way finishes (a task Albert is working on carries on) and nothing new starts |
| **Resume** | Carries on from where it paused |
| **Try again** | A stopped queue picks up at the slice that stopped, with fresh attempts |
| **Cancel** | Asks first, then cancels the task under way. What was verified stays verified |
| **Clear** | Removes a finished or cancelled queue's summary |

**When it stops or pauses by itself.** The queue never guesses; it stops with the reason:

- You rejected Albert's plan or change, or Albert's task failed or was cancelled: **Try again** asks again.
- A build left the slice unbuilt: it is tried once more, then the queue stops and says what is missing.
- A verification failed: Albert repairs it, at most 3 times (or the queue stops, if you unticked repair).
  After 3 failed repairs it stops: **Roll back** on the slice, or change the design.
- The slice needs a service connected, or a part the map does not have: the queue pauses. Connect it on
  the map, or decide it on the **Plan** stage, then **Resume**.
- Something the app needs is not installed (a part's packages, the browser test runner, or a browser):
  the queue pauses with *Install what it needs, then resume*, and lists each one with its own **Install**
  button. Install them, then **Resume**: it verifies again. If you installed them another way, in a
  terminal, **Resume** verifies again too. This is never sent to Albert to repair, and does not count
  against the slice's verifications.

**Never twice.** One queue at a time per repository and environment. While a queue runs or is paused,
the slices' own buttons are hidden and AlbertCode refuses to build, verify, repair or roll back a slice
by hand. The queue also never starts a task while another change is under way in the repository: it
says *Waiting for another change in this repository to finish first.*

A change to the code leaves every earlier verification out of date, so when an earlier slice is no longer
verified the queue verifies it again before carrying on, and says so on that slice.

**It lasts.** The queue is kept with the map, so refreshing or closing the page does not stop it. After
AlbertCode restarts, it waits with *AlbertCode restarted: open the System page to carry on*, because
the tasks are made as you; opening the System page carries it on.

**Example.** A notes app on a Vite front end, a FastAPI API and SQLite has six slices: *The app runs*,
*Add SQLite*, *Write a note*, *List notes*, *Search notes* and *Every journey, end to end*. You tick
**Select all**, keep **Governed**, and press **Build all (6)**. The queue starts with the app:
*Processing*, then *Waiting for you*. **Open** shows Albert's plan (the API and the web app, each
starting and answering, and nothing else); you approve it, then accept the change. The slice moves to
*Verifying*: both parts start and answer, and it shows **Verified**. Then SQLite is added to the API
through its adapter; the queue pauses for you to connect it on the map, and after **Resume** it is
verified the same way. *Write a note* connects them, from the screen to the
table and back, and its journey passes in the browser. *Search notes*' verification fails, so Albert
repairs it (*repair 1 of 3*), you accept the fix, and it passes: **Build queue · 6 of 6 done**.

### Verification

**Verify** proves a slice on evidence, never on a command that ran or a port that opened:

1. **Read the repository**: how many parts are in the code.
2. **Install what the app needs**, only when something is missing: a part's packages, the browser test
   runner, or a browser to run the tests in. The verification stops here, before starting anything, and
   lists each one with what installs it (`npm install` in `web/`, for example) and an **Install** button.
   Installing fetches from the network and runs what it fetches, so it is always your click. This is not
   a failure of the code: press **Install** on each, then **Verify again**. A browser the tests could
   not start is found here too, even after the app has started: Playwright's own was never downloaded,
   and the tests do not use the Chrome, Edge or Chromium AlbertCode found on the computer (it names it in
   `PW_CHROMIUM_PATH`, which each slice's request asks the tests to use).
3. **Start the app**: every part the slice needs, through the [runtime](#run-every-part). A service
   connected on the map that does not answer where it is (a database that is down, say) stops it here:
   the slice asks you to start it or change its connection, and is never sent to Albert to repair.
4. **Each part answers its health route**.
5. **Check each connected service**, each named with what it answered (*Database: Signed in · 4
   tables · read-only query answered*), and each one the runtime runs itself: in Development, with
   `redis-server` installed and no Redis connected on the map, the runtime's own Redis answering is
   the check (*Cache and job queue, run here: PING answered*), and there is nothing to connect.
6. **Walk every journey in a browser**: the browser tests titled `[R…]` for this slice and the ones
   before it, at the app's one address. **The app** and a **Service** have no journey of their own, so
   their verification ends at step 5 (and needs no browser test runner); each feature walks its own.

A verification proves the slice it is for and every slice before it, so a slice can be verified once the
ones before it are built. When one fails, the first slice it did not prove is the one to repair: an API
that no longer starts is **The app**'s to fix, not the feature's.

When everything passes, AlbertCode keeps a **checkpoint**: a Git commit of the code that passed, kept
under `refs/albertcode/checkpoints/<environment>` and not on any of your branches (files that may hold
secrets are left out). **Roll back** returns to it. Checkpoints need the folder to be a Git
repository. When the code changes after a verification, the evidence goes stale: *the code has changed
since*, and the slice must be verified again.

### Statuses on the map

Every part and connection a feature needs shows its status on the map, worked out from evidence only: what
the code holds, a verification of the code as it is now, and what the runtime sees now.

| Status | A part | A connection |
|---|---|---|
| **Planned** | Not in the code yet | Not in the code yet |
| **Building** | Albert is writing it now: in the [build queue](#build-several-slices-build-selected-build-all), or in the chat beside the map. One part at a time | Albert is making the connection now |
| **Built** | Its code is in the repository, but nothing has proven it answers yet | The code makes the connection |
| **Connected** | It answers: its health route in a verification of this code, or to the runtime now; for a service, its check passes | Both ends answer |
| **Testing** | A verification through it is running now | A verification through it is running now |
| **Verified** | A journey that passed on the code as it is now goes through it | A journey that passed on the code as it is now goes through both ends |
| **Failed** | A verification of this code found it failing, its check fails, or the runtime finds it down now | A journey through it failed, or one of its ends is failing |

Only **Verified** is green, and only on evidence about the code as it is now. Change the code and earlier
evidence is out of date: green parts go back to **Connected** (if the runtime still finds them answering)
or **Built** until a slice through them is verified again; red clears the same way. An outside service
that Albert uses a stand-in for stays **Built** until its own slice connects the real one. A line to a
part a later slice builds (the API's line to CI, say) waits for that slice, and does not hold back the
parts and features verified before it. Select a part or a connection to read why it has its status.
Parts no feature needs show their check, as before.

**Example.** In the notes app, *The app runs* passes: Web app and API turn **Connected**, because they
answer but no journey has gone through them yet. *Add SQLite* passes: SQLite turns **Connected** too.
*Write a note* passes: all three turn **Verified**. You edit `api/main.py`: all three show **Connected**,
because the runtime still finds them answering but no journey has passed on the new code. You press **Verify** and the journey fails: the parts it walked through show
**Failed**, and selecting one shows the journey's error. Albert repairs it, the verification passes, and
they are green again.

The **Build** stage's slices, the stage row and the bar's next step use the same evidence.

**Out of step** lists where the map, the code and what ran disagree: an endpoint the API does not
serve yet, a line drawn that the code does not make, a database in the code that is not connected on
the map. **Not built** lists boxes no feature needs: they would be code with nothing to do.

## Run every part

**Start all**, in the bar, runs your whole app on this computer: every part the app needs, in the
order they need each other, each on a port of its own, wired to the others, and reached at **one
address**. **Operate** → **Run** shows it:

```text
Running · 3 of 3 up · all healthy                         [Restart all] [Stop all]
Your app  localhost:4400                                   [Preview]

● Web app        5173   Healthy    npm run dev in web/
● API            8001   Healthy    uvicorn main:app in api/
● Notes database  File  Healthy    A file the app opens itself: nothing to start
```

### How each kind of part runs

| Part | How it runs |
|---|---|
| A front end (Next.js, Vite, Nuxt, your own) | Its folder's `dev` or `start` script, with the package manager the folder uses |
| An API: FastAPI, Flask, Django | Its framework's own server, found from your code, with the project's virtual environment (`.venv`, `venv` or `env`) when it has one |
| Express and other Node APIs | Its folder's script |
| A worker: Celery, your own | Its command; it proves itself when it prints its ready line |
| Redis, with no connection on the map | Its own `redis-server`, private to this project, kept in memory |
| SQLite, your own data store | A file the app opens: nothing to start |
| A service connected on the map | Never started twice: checked where it is, and its address given to the parts that use it |
| An outside service | Reached at its own address by the app |
| Anything else (a PostgreSQL in `docker-compose.yml`, for example) | Said plainly: start it yourself (for example `docker compose up -d`), then connect it on the map, and its check decides when it is up |

A part with no code yet is *Not built*. One AlbertCode cannot work out how to start says why
(*Cannot run here*): give it a `dev` script, or say how it runs in its
[run settings](#run-settings).

### Up means proven

A part counts as up only on evidence:

- an app part when its health route answers (`/health`, `/healthz`, `/status` or `/ready`, also under
  the app's API prefix), or for a front end when its first page answers;
- a worker when it prints its ready line;
- a database or cache when its own check answers.

| State | Meaning |
|---|---|
| **Stopped** | Not running |
| **Healthy** | Proven, as above |
| **Running** | Its process is up, but nothing proves it works (no health route, no ready line) |
| **Starting**, **Waiting**, **Installing** | On its way; waiting for a part it needs; installing packages |
| **Unhealthy** | It runs but fails its check, or its code fails to load (said within seconds) |
| **Crashed**, **Failed** | It stopped by itself; or it could not start |
| **Not started** | A part it needs is not up |
| **Not built**, **Cannot run here**, **Elsewhere** | No code yet; AlbertCode cannot start it (with why); connected on the map and checked where it is |

### Wiring and the one address

Each part is given:

| Variable | Value |
|---|---|
| `PORT`, `HOST` | Its own port, on `127.0.0.1` |
| `APP_URL` | The app's one address |
| `API_URL` | The API it uses |
| `DATABASE_URL`, `REDIS_URL`, `MONGODB_URI`, `AMQP_URL`, `NATS_URL`, `KAFKA_BROKERS`, `SMTP_URL`… | Each service it uses, from its connection on the map or the runtime's own Redis |
| `STRIPE_SECRET_KEY`, `RESEND_API_KEY`, `CLERK_SECRET_KEY`, `MODEL_API_KEY`… | Keys of connected services, read from your key store when the part starts, and masked in everything it prints |
| Your proxy and certificate settings | So installs and outside calls work on your network |

**The one address** (usually `localhost:4400`) serves the whole app: the paths your API serves (such
as `/api/…`) go to the API, everything else to the front end, and WebSockets work. When a part's port
has to move, the address stays the same. While a part starts, the address shows a *Starting…* page
that reloads by itself.

### Keeping it running

- **It runs while Albert works.** Tasks come and go; the app stays up.
- **Recovery.** A part that stops by itself is started again after 2, 5 and 10 seconds: at most three
  times in ten minutes, then it is left stopped with the reason. A dev server that reloads after a bad
  edit is not restarted: it answers again once the code is fixed.
- **Started again, never twice.** Pressing **Start all** while the app runs leaves alone each part
  that works and still has the right addresses. A part that runs but does not work, or that started
  before a service it uses was connected on the map (or before a part it reaches moved to another
  port), is stopped and started again in its place, never beside itself. So is a part whose code has
  changed since it started and that does not reload by itself: a Celery worker, a `start` script or a
  command of your own (dev servers such as `next dev`, `vite`, `uvicorn --reload`, Flask in debug mode
  and Django's `runserver` reload by themselves). A verification does the same before it checks
  anything, so no part is judged by an address it was never given, or by code it is not running. Its
  log says why:

  ```text
  API  Starting it again: what it reaches has changed since it started
  API  $ python3 -m uvicorn main:app --host 127.0.0.1 --port 8000 --reload  (in api)
  API  INFO:     Application startup complete.
  ```
- **Install packages.** A part whose packages are missing says so before it starts, with the exact
  command: **Install packages** runs it (`npm install` or your package manager; for Python, a `.venv`
  and `pip install`). A failed install says why, for example a network that needs a proxy. For a
  Python part, every package its `requirements.txt` (or `pyproject.toml`) lists is checked, not only
  its framework, so a package added in a later step is found before the part starts:

  ```text
  Workers  Its packages are not installed
           Declared in its project but not installed: redis. Install packages runs it for you.
  ```
- **Logs.** The **Log** section shows what every part prints, or one part's, with errors marked. Keys
  are masked. **Its log** on a part jumps to it.
- **Fix with Albert** on a part that fails sends Albert how it was started, what it printed and what
  it must answer, as a plan you approve.
- **Stop all** stops every part and everything it started. Starting **Preview** stops the runtime
  first, and quitting AlbertCode stops it too. Parts left running by an AlbertCode that ended without
  stopping them are found and stopped the next time it starts.

Up to four projects can run at once, each with its own ports.

## Your own parts

For a part the library does not describe (a Go service, a Rust worker, a data store you run
yourself), add one of the **Your own** entries: **Your own front end**, **Your own service**, **Your
own worker** or **Your own data store**. Rename it, connect it to the parts it talks to, and say how
it runs. Albert builds each in a folder named after it (*Pricing service* goes in `pricing-service/`),
and the box turns solid when that folder has code.

This works from an empty folder too: design the whole app from your own parts, then build it slice by
slice.

### Run settings

**How it runs**, in a part's details, says how the runtime starts it, before any guess:

| Field | Meaning |
|---|---|
| **Folder** | Where it runs from, inside the repository (optional) |
| **Start command** | The command; `{port}` becomes the port it is given, and it gets `PORT` too |
| **Port** | Its usual port (optional) |
| **Health route** | A `GET` route that answers 2xx when it works, such as `/health` (optional) |
| **Ready line** | For a part with no port: what it prints when it is ready, such as `worker ready` |

```text
Folder         services/pricing
Start command  go run . --port {port}
Port           8100
Health route   /health
```

**Go by the repository** clears them. Albert is asked to make the part run exactly this way, and the
build request says so. A folder outside the repository, a folder that looks like it holds secrets, or
a command that can't be read is refused with the reason.

## Verify: what passed, and every problem

The **Verify** stage first says how many slices are verified and whether the last verification passed
(and whether the code has changed since), with the next **Verify** or **Repair** and **Every slice**,
which opens the **Build** stage. Below, it (and **N to fix** in the bar) lists every open problem for the
environment shown, from the evidence:

| Stage | Problems |
|---|---|
| **Running in** the environment | Services failing their last check |
| **Testing** | Failing browser tests, and requirements whose tests fail |
| **Development** | Contract items not in the code at both ends |

Each comes with its evidence and file. **Fix with Albert** asks for one; tick several (or none, for
all) and press **Fix the N chosen** / **Fix all N with Albert** to ask for them together. Each request
is a plan you approve, with a test that would have caught it. A problem's chat is filed under the part,
test, requirement or connection it is about.

## Release: only after verification

**Operate** → **Release** checks one environment before anything goes out, and records what went out.

1. **Is it ready?** runs every check for the environment shown: your code is committed, the app is
   verified end to end on this very code, every service connected there passes a check run now, your
   browser tests, requirements and contracts hold, and nothing you designed is left unbuilt. Anything
   that could not be checked is a warning, never a pass.

   *Verified end to end* applies once you have planned the features: every slice must be verified on
   the code being released. Verification starts the app on this computer and walks its journeys, so it
   is done in Development whatever you release to: journeys never run against Staging's or Production's
   data. Change the code after verifying and the release is refused until you verify again.
2. When nothing is marked ✕, **Release** records the commit, with an optional note, and tags it
   `release-<environment>-<number>` in your repository (for example `release-staging-3`). AlbertCode
   runs the checks again at that moment and refuses if anything fails, including files you changed and
   did not commit.
3. **Deploy** the tagged commit with your own pipeline or command: AlbertCode does not deploy for you.

**Observe.** **Check now** checks every connected service in the environment and keeps the result in
the strip; tick *Check every minute while this page is open* to keep watching.

**Repair.** When something fails after a release, **Fix with Albert** sends what failed and what
changed since the last release.

**Roll back.** Each release you have moved on from offers **Roll back to this** (for the latest,
**Undo what changed since**). Albert receives the exact change back to that release, worked out by
AlbertCode and checked to apply cleanly, and makes it as a plan you approve; then commit it and release
again. Commit or put aside your own changes first. When the change is very large, AlbertCode gives you
the `git revert` command to run instead.

## What AlbertCode does not do

Some things you might expect are deliberately not done, or not done yet. Each is said here rather than
imitated:

| Not done | Why, and what to do instead |
|---|---|
| **Deploying** | AlbertCode checks, records and tags a release; your own pipeline or command deploys the tagged commit. It never runs deploy commands or holds deploy credentials, so nothing it runs changes a live environment by itself. If your pipeline deploys tags, `git push origin release-staging-3` deploys that release |
| **Starting containers** | Parts run as processes on this computer. Start containers yourself (for example `docker compose up -d db`), then connect them on the map; their checks then say when they are up. Services in the cloud, or anywhere else, are connected the same way |
| **Verifying against Staging or Production** | Journeys are walked in Development only. Other environments are checked read-only, by each service's own check |
| **Pausing a task halfway** | The build queue pauses between steps: a task Albert is working on finishes its step, or you cancel it |
| **Resizing or grouping boxes** | Every box has one size and sits in its lane; **Tidy** lines them up |

## Your own services in a file (advanced)

The easy way to add your own API or MCP server is from the library: *REST API (OpenAPI)*, *GraphQL
API*, *MCP server* or *Webhook*. For a service those do not cover, describe it in
`system-providers.json` in AlbertCode's data folder (see
[where AlbertCode keeps things](how-it-works.md#what-albertcode-keeps-and-where)):

```json
[{"id": "acme-crm", "name": "Acme CRM", "desc": "Our CRM's API",
  "probe": {"kind": "http", "url": "https://api.acme.example/me", "auth": "bearer"},
  "fields": {"secret": {"label": "API key"}}, "fns": [{"label": "List contacts"}]}]
```

`kind` is `http`, `openapi`, `graphql`, `mcp` or `app`. An `http` check's URL must start with
`https://` or with `{address}` (the address you type when connecting). Only this file is read, never
one in a repository.

## Examples

### From an empty folder to a verified notes app

1. Make a folder and open it: **Browse → New folder**, then **Open**.
2. **System** → **Describe it**: *"A notes app: write a short note and keep it in a list."*
3. **Backbones** is optional; here, **Add service** → *Vite + React*, *FastAPI* and *SQLite*. Connect
   Web app → API → SQLite by dragging the dots.
4. **Plan the features**. The plan lists *Add a note and see it in the list*, with its journey (*Open
   the app → Type a note and add it → See it in the list*) and requirement R1.
5. The bar now says **Build: The app runs**. Press it, read the plan, approve it, then accept the diff.
   Albert writes the API in `api/` and the web app in `web/`, each starting and answering its health
   route, the web app reaching the API, and nothing else yet. It lists what each part needs in
   `api/requirements.txt` and `web/package.json`, and does not install them.
6. **Verify**. Nothing is installed yet, so it stops at **Install what the app needs**: *Web app:
   `npm install` in web/; API: `python3 -m venv .venv && .venv/bin/python -m pip install -r
   requirements.txt` in api/*. Press **Install** on each; each turns *Installed*.
7. **Verify again**. AlbertCode starts both parts and each answers: *The app runs* is *Verified*.
8. **Build: Add SQLite**. Albert adds the database to the API through an adapter, with its migration set
   up and no tables yet. The slice then shows **Connect**: connect SQLite on the map so AlbertCode can
   check it, then **Verify**: the API answers and the check reaches the database.
9. **Build: Add a note and see it in the list**. Albert adds the notes table, its endpoint, the screen
   and a `[R1]` browser test that walks the journey. **Verify** stops once more, for *The browser test
   runner: `npm install`*: press **Install**, then **Verify again**. AlbertCode walks the `[R1]` test at
   the app's one address. Everything passes: the slice is *Verified* and a checkpoint is kept.
10. **Start all** keeps the app running at `localhost:4400` while you build the next feature.

With **Build all** instead of each slice's own button, the same happens on its own, one slice after
another: the queue pauses at step 6 and step 9 with the same lists and **Install** buttons, and
**Resume** carries on each time.

### Connect PostgreSQL in Staging without saving its password

```bash
export STAGING_DB_PASSWORD="…"
albertcode --ui
```

1. **+** → **Staging**.
2. Select the PostgreSQL box → **Connect** → tick **Read them from environment variables** →
   **Address** `postgres://app@staging-db:5432/app`, **Password** `${STAGING_DB_PASSWORD}`.
3. The check runs at once: *Working*. Only the name `STAGING_DB_PASSWORD` is kept, never the password.

### A Go service of your own, next to a Vite front end

1. **Add service** → **Your own service**; rename it *Pricing service*.
2. **How it runs** → Start command `go run . --port {port}`, Port `8100`, Health route `/health` →
   **Save**.
3. Connect the front end to it, and **Plan the features**.
4. Build **The app runs**: Albert writes the service in `pricing-service/`, serving `GET /health`, and
   the front end that reaches it.
5. **Start all**: the runtime runs `go run . --port 8100` in `pricing-service/`, and the part turns
   *Healthy* when `GET /health` answers.
