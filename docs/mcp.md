# MCP servers

[Model Context Protocol](https://modelcontextprotocol.io) servers give Albert outside tools: Git,
a browser, a database, documentation, your company's own services. AlbertCode connects to servers that
run on your computer (a local command) and servers on the web (a URL), including ones that need you to
sign in.

## The quickest way: connectors

**Connectors** is a gallery of 88 ready-made servers. Each one is added with a click and, at most, the
answers it needs: a sign-in for services on the web, a folder, or a database address. Every connector
in the gallery has been run for real: started or reached the way AlbertCode does it, with its tools
listed and one of them called (each database connector against a real database of its kind). A
connector that signs in was taken up to the service's own sign-in page: AlbertCode registered itself
with the service, and the rest is your own account.

### Code and repositories

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| Git (`git`) | Read and search a local Git repository: status, diffs, log, branches | The repository folder |
| Filesystem (`filesystem`) | Read, write and search files, only inside the folders you name | The folders |
| GitLab (`gitlab`) | Issues, merge requests, pipelines and code search in your GitLab projects | Sign in |
| Serena (`serena`) | Find symbols, references and definitions through language servers, and edit code by symbol | The project folder |

### Projects and work

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| Linear (`linear`) | Find, create and update Linear issues, projects and comments | Sign in |
| Notion (`notion`) | Search, read and write Notion pages and databases | Sign in |
| Jira and Confluence (`atlassian`) | Search and update Jira issues and Confluence pages (Atlassian Rovo) | Sign in |
| Asana (`asana`) | Tasks, projects, goals and comments in Asana | Sign in |
| monday.com (`monday`) | Boards, items, updates and workspaces on monday.com | Sign in |
| ClickUp (`clickup`) | Tasks, lists, docs and time tracking in ClickUp | Sign in |
| Todoist (`todoist`) | Tasks, projects, sections and comments in Todoist | Sign in |
| Airtable (`airtable`) | Bases, tables and records in Airtable | Sign in |
| Zapier (`zapier`) | Run actions in thousands of apps through your Zapier account | Sign in |
| Fireflies (`fireflies`) | Search meeting transcripts, summaries and action items from Fireflies | Sign in |

### Docs and search

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| AWS Documentation (`aws-docs`) | Search and read AWS documentation pages |  |
| AWS Knowledge (`aws-knowledge`) | AWS documentation, API references, What's New posts and regional availability, with nothing to install |  |
| Microsoft Learn (`microsoft-learn`) | Search and read Microsoft and Azure documentation and code samples |  |
| Context7 (`context7`) | Up-to-date documentation and code examples for thousands of libraries |  |
| DeepWiki (`deepwiki`) | Ask questions about any public GitHub repository and read its generated wiki |  |
| GitMCP (`gitmcp`) | Documentation and code of any public GitHub project, read from the repository itself |  |
| Cloudflare Docs (`cloudflare-docs`) | Search Cloudflare's developer documentation |  |
| Exa (`exa`) | Web search, page contents and code search built for agents |  |
| Fetch (`fetch`) | Fetch a web page and hand it to the agent as Markdown |  |
| Hugging Face (`huggingface`) | Search models, datasets, Spaces and papers on the Hugging Face Hub. Sign in for your own | Sign in, for your own |
| Wolfram (`wolfram`) | Wolfram|Alpha answers and Wolfram Language computation: maths, science, data and units |  |

### Browser and testing

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| Playwright (`playwright`) | Drive a real browser: open pages, click, type, read what is on screen, take screenshots | Needs Chrome |
| Chrome DevTools (`chrome-devtools`) | Inspect a live Chrome: console, network, performance traces and the DOM | Needs Chrome |
| Cloudflare Browser Rendering (`cloudflare-browser`) | Fetch pages, take screenshots and turn pages into Markdown on Cloudflare's browsers | Sign in |

### Frameworks

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| Next.js DevTools (`next-devtools`) | Next.js documentation, upgrades and a running app's errors and routes |  |
| Angular CLI (`angular-cli`) | Angular best practices, documentation search and the projects in an Angular workspace |  |
| Nx (`nx`) | An Nx workspace's projects, tasks and generators, and Nx documentation | The workspace folder |
| Shopify Dev (`shopify-dev`) | Shopify's developer documentation and API schemas, and checks for Liquid and GraphQL |  |
| ESLint (`eslint`) | Lint JavaScript and TypeScript files with the project's own ESLint setup |  |
| n8n (`n8n`) | Every n8n node's documentation and properties, and checks for workflows before you import them |  |

### Cloud and deployment

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| Vercel (`vercel`) | Projects, deployments, build logs and documentation on Vercel | Sign in |
| Netlify (`netlify`) | Create, deploy and manage Netlify sites, forms and environment variables | Sign in |
| Cloudflare Workers (`cloudflare-bindings`) | Workers, KV, R2, D1 and Hyperdrive in your Cloudflare account | Sign in |
| Cloudflare Workers Builds (`cloudflare-builds`) | Builds and their logs for your Cloudflare Workers | Sign in |
| Cloudflare Observability (`cloudflare-observability`) | Your Workers' logs and analytics, searched and summarised | Sign in |
| Cloudflare Radar (`cloudflare-radar`) | Internet traffic trends, outages, attacks and URL scans from Cloudflare Radar | Sign in |
| Railway (`railway`) | Projects, services, deployments, logs and variables on Railway | Sign in |
| CircleCI (`circleci`) | Pipelines, failed jobs, their logs and flaky tests on CircleCI | Sign in |
| Buildkite (`buildkite`) | Pipelines, builds, jobs and their logs on Buildkite | Sign in |
| Docker (`docker`) | Containers, images, networks and volumes on this machine's Docker | Needs Docker running |
| Kubernetes (`kubernetes`) | Pods, deployments, services, logs and Helm charts in the clusters your kubeconfig names | Needs kubectl |

### Databases

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| PostgreSQL (`postgres`) | Read-only SQL, schema details and query plans for one PostgreSQL database | The connection URI (`uri`) |
| SQLite (`sqlite`) | Query and change one SQLite database file, and describe its tables | The database file |
| DuckDB (`duckdb`) | Read-only SQL over a DuckDB database, and over the CSV, Parquet and JSON files it can read | The database file |
| MySQL (`mysql`) | SQL and table listings for one MySQL or MariaDB database | Host, port, user, password, database |
| MongoDB (`mongodb`) | Collections, documents, indexes and aggregations in MongoDB, read-only | The connection string (`uri`) |
| Redis (`redis`) | Keys, hashes, lists, streams, JSON and vector search in a Redis database | The Redis URL (`url`) |
| Neo4j (`neo4j`) | The graph's schema, and Cypher queries against a Neo4j database | URI, user, password |
| ClickHouse (`clickhouse`) | Databases, tables and read-only SQL on a ClickHouse server | Host, port, user, password |
| Chroma (`chroma`) | Collections and documents in a Chroma vector database kept in a folder | The data folder |
| Supabase (`supabase`) | Tables, SQL, migrations, edge functions and logs in your Supabase projects | Sign in |
| Neon (`neon`) | Projects, branches, SQL and migrations on Neon serverless Postgres | Sign in |
| Prisma Postgres (`prisma`) | Create and manage Prisma Postgres databases and run migrations | Sign in |
| PlanetScale (`planetscale`) | Databases, branches, schema, query insights and SQL on PlanetScale | Sign in |

### Monitoring and analytics

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| Sentry (`sentry`) | Errors, issues, traces and releases in Sentry, and Seer's suggested fixes | Sign in |
| PostHog (`posthog`) | Product analytics, feature flags, experiments and errors in PostHog | Sign in |
| Amplitude (`amplitude`) | Charts, dashboards, cohorts and experiments in Amplitude | Sign in |
| Mixpanel (`mixpanel`) | Events, funnels, retention and reports in Mixpanel | Sign in |
| Honeycomb (`honeycomb`) | Traces, queries, SLOs, triggers and boards in Honeycomb | Sign in |
| Axiom (`axiom`) | Datasets, schemas and APL queries over your logs and events in Axiom | Sign in |
| Datadog (`datadog`) | Logs, metrics, traces, monitors, incidents and dashboards in Datadog | Sign in |
| New Relic (`newrelic`) | Metrics, logs, traces and alerts in New Relic, queried in plain language or NRQL | Sign in |

### Design and content

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| Canva (`canva`) | Create, search, edit and export Canva designs | Sign in |
| Miro (`miro`) | Read and add to Miro boards: diagrams, documents, tables and sticky notes | Sign in |
| Lucid (`lucid`) | Create, search and summarise Lucidchart and Lucidspark documents | Sign in |
| Whimsical (`whimsical`) | Flowcharts, mind maps, wireframes and docs in Whimsical | Sign in |
| Webflow (`webflow`) | Sites, pages, CMS collections and items in Webflow | Sign in |
| Wix (`wix`) | Build and manage Wix sites, and search Wix's developer documentation | Sign in |
| Sanity (`sanity`) | Documents, datasets, releases and schemas in your Sanity projects | Sign in |

### Business and payments

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| Stripe (`stripe`) | Customers, products, prices, payments and refunds in Stripe, and Stripe's documentation | Sign in |
| PayPal (`paypal`) | Invoices, orders, payments, disputes and subscriptions on PayPal | Sign in |
| Square (`square`) | Payments, orders, catalog, customers and inventory on Square | Sign in |
| Intercom (`intercom`) | Conversations, contacts and help-centre articles in Intercom | Sign in |
| Close (`close`) | Leads, contacts, opportunities and activities in Close CRM | Sign in |
| Attio (`attio`) | Records, lists, notes and tasks in your Attio CRM | Sign in |
| PandaDoc (`pandadoc`) | Create, send and track PandaDoc documents and templates | Sign in |
| Apify (`apify`) | Run thousands of ready-made web scrapers and automations from the Apify Store | Sign in |
| WorkOS (`workos`) | Organisations, users, SSO, Directory Sync and AuthKit in WorkOS | Sign in |

### Utilities

| Connector (id) | What it gives Albert | Asks for |
|---|---|---|
| Memory (`memory`) | A knowledge graph the agent can keep notes in across sessions |  |
| Sequential Thinking (`sequential-thinking`) | A place to work through a hard problem step by step |  |
| Time (`time`) | Current time and time-zone conversion |  |
| Excel (`excel`) | Read, write and format Excel workbooks: sheets, formulas, charts and pivot tables, without Excel |  |
| MarkItDown (`markitdown`) | Turn PDF, Word, Excel, PowerPoint, HTML and other files into Markdown the agent can read |  |
| Everything (test server) (`everything`) | The protocol's reference server: sample tools, prompts and resources, for trying MCP out |  |

Local connectors need what they run on: **uv** (`uvx`), **Node.js** (`npx`), and for some Chrome,
Docker or kubectl. The gallery says which. The first start downloads the server, so it may take a
minute; later starts are quick.

| Interface | How |
|---|---|
| Terminal | `/connectors`, or `/connectors postgres` to search; `/mcp install <id> key=value` adds one without questions |
| Browser | **MCP servers** (⋮ menu) → **Browse connectors**, or **Connectors** in the command palette. Pick a category, or search |
| VS Code | **Browse MCP Connectors** |

```text
/mcp install postgres uri=postgresql://localhost:5432/app
/mcp install git repository=.
/mcp install mongodb uri={env:MONGODB_URI}
/mcp install linear              # then sign in: your browser opens Linear's own sign-in page
/mcp install context7            # no sign-in: up-to-date library docs straight away
```

A connector that signs in, such as Linear, Notion, Jira, Stripe or Sentry, needs nothing but your
account: AlbertCode registers itself with the service, opens its sign-in page, and comes back connected
once you approve. For example, to give Albert your Linear issues:

1. **Browse connectors** → **Projects and work** → **Linear** → **Connect**.
2. Linear's own page opens in a new tab: sign in, and approve AlbertCode.
3. Back in AlbertCode, Linear shows **Connected**, with its tools. Ask "What is assigned to me this week?"

A few popular services are not in the gallery yet, because the check could not show them working:
Box, HubSpot, ElevenLabs and Render make you register a client by hand; Figma and Sonatype take
only clients they approved; GitHub needs your personal access token to be checked. Any of them can
still be added by hand: **Add server**, with its URL (and a client ID where it needs one).

## Add any server

| Interface | How |
|---|---|
| Terminal | `/mcp add`, then answer: a local command, or a remote URL |
| Browser | **MCP servers** → **Add server**: a name, then a **Local command** (its command and environment) or a **Remote URL** (its address, OAuth or headers) |
| VS Code | **Add an MCP Server** |
| A script | `albertcode mcp add …` (below) |

```bash
# A local server: a command AlbertCode starts, with its variables
albertcode mcp add docs --command "npx -y @example/docs-mcp" --env DOCS_TOKEN=xyz

# A remote server that signs you in with OAuth (a browser window opens)
albertcode mcp add tracker --url https://mcp.example.com/mcp

# A remote server that takes a header instead
albertcode mcp add search --url https://search.example.com/mcp --no-oauth --header "Authorization=Bearer xyz"
```

## Signing in

A remote server that needs a sign-in shows **Needs auth**. `/mcp auth <name>` (or **Sign in** in the
browser and VS Code) opens your browser to sign in; the token is kept in your system's key store and
refreshed for you. `/mcp logout <name>` (**Sign out** in the browser) removes it. A server that needs a
client ID registered by hand shows **Needs client ID**: give it as the server's **OAuth client ID**.

The sign-in asks only for what the server says it needs. GitLab's MCP server, for example, asks for
the `mcp` permission alone, so that is all the sign-in page asks you to grant, even though GitLab's
sign-in offers many more (administrator rights among them). To ask for something else, give the
server a scope of your own in `mcp.json`, the file beside your credentials that holds your servers:

```json
"tracker": {"type": "remote", "url": "https://mcp.example.com/mcp", "oauth": {"scope": "read write"}}
```

## Managing servers

| Terminal | Browser (**MCP servers**, then a server's **Edit**) | What it does |
|---|---|---|
| `/mcp` | The list | Pick one to switch it on or off |
| `/mcp list` | The list | Every server, its status and its tools |
| `/mcp tools <name>` | Its tool switches | Switch single tools on or off |
| `/mcp enable <name>`, `/mcp disable <name>` | Its switch | Switch a server on or off |
| `/mcp connect <name>` | **Reconnect** | Connect again |
| `/mcp debug <name>` | Its details | Why a server is not working: its command, its output, the error |
| `/mcp remove <name>` | **Delete** | Remove a server |

In VS Code, **MCP Servers** offers the same.

| Status | Meaning |
|---|---|
| **Connected · 12 tools · 3 prompts** | Working, with what it offers |
| **Connecting…** | Starting or reaching it |
| **Needs auth** | Sign in with `/mcp auth <name>` |
| **Needs client ID** | The server needs a client registered by hand |
| **Disabled** | Switched off |
| **Failed: …** | With the error; `/mcp debug <name>` says more |

The sidebar's **MCP** chip in the browser shows how many are connected, and the terminal says when a
server connects, drops or wants a sign-in. A server that drops is reconnected by itself.

## Prompts and resources

Servers can offer **prompts** (ready-made requests) and **resources** (documents and data):

```text
/mcp prompts                       # what servers offer
/github:review-pr 128              # use a prompt: /server:prompt arguments
/mcp resources                     # what servers offer
/mcp attach docs docs://api/orders # attach a resource to your next message
```

In the browser, **MCP prompts and resources** in the command palette; in VS Code, **Use an MCP Prompt
or Resource**. A prompt's text is sent as your message, shown in full.

## What a server may do

An MCP server's tools are governed like everything else:

- While Albert plans or answers questions, only tools that read are offered.
- A tool that acts (writes, sends, changes something) needs your approval: **Allow** in the browser and
  VS Code (or **Allow, and stop asking**), `a` in the terminal.
- Every call is recorded in the evidence ledger.
- A [custom agent](extending.md#custom-agents) without the `mcp` group cannot use MCP tools at all.

Servers you add are yours, for every repository. Servers a [plugin](plugins.md) brings are named
`<plugin>-<name>` and removed with the plugin.
