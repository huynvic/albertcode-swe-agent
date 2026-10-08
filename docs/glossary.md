# Glossary

The words AlbertCode uses, in one place.

| Word | Meaning |
|---|---|
| **Accept** | Approval 2: apply a finished change to your repository. Refused if you edited a file it touches meanwhile |
| **Agent (custom)** | A role Albert works as, written in Markdown, which can only take tools away. See [Extending](extending.md#custom-agents) |
| **Albert** | AlbertCode's agent: the one you talk to |
| **Approval 1, approval 2** | The two points where a governed change waits for you: the plan, then the diff |
| **Ask only** | The mode where questions are answered and changes are only offered |
| **Attachment** | A file or picture sent with your next message (up to 500 MB) |
| **Backbone** | A ready-made system design to start the System map from; 21 come with AlbertCode, and you can save your own |
| **Boundary** | The limits a repository's [contract](contract.md) sets; also the button on the repository card |
| **Build Manifest** | The System page's plan of what to build, in which order, and how far the evidence takes each part |
| **Build queue** | Slices you chose with **Build selected** or **Build all**, built and verified one after another; see [Build several slices](system.md#build-several-slices-build-selected-build-all) |
| **Checkpoint** | A Git commit kept when a slice passes its verification, which **Roll back** returns to |
| **Command (custom)** | A message you send often, used by name: `/review src/cart.py` |
| **Connected (a part)** | It answers: its health route in a verification of the code as it is, or to the runtime now; for a service, its check passes. Not yet proven by a journey |
| **Connector** | A ready-made MCP server you add in a couple of answers |
| **Contract (repository)** | `albertcode.contract.toml`: what AlbertCode may do in a repository. See [The contract](contract.md) |
| **Contract (on a connection)** | What a line on the System map carries (endpoints, tables, topics), looked for in the code at both ends |
| **Direct** | The mode that works in your real files, asking before each write or applying them as they come |
| **Environment** | Development, Staging or Production on the System page: each with its own connections, keys, checks and releases |
| **Evidence** | What a task leaves: the plan, the commands and results, the checks, the reviews, the diff and the approvals |
| **Evidence ledger** | The record of everything AlbertCode did, each entry linked to the one before, so a change is detected |
| **Gateway, one address** | The single address (usually `localhost:4400`) where **Start all** serves your whole app |
| **Governed** | The default mode: plan, approval, isolated build, checks, reviews, approval, apply |
| **Health route** | A `GET` route that answers 2xx when a part works, such as `/health` |
| **Isolated copy** | The private copy of your repository a governed task works in, so your files stay untouched until you accept |
| **Journey** | The steps a person takes through a feature, which a browser test walks |
| **Language checks** | The checker each edited file is run through (pyright, gopls…), so Albert fixes what its edit broke |
| **Library** | The 113 services you can add to the System map |
| **MCP server** | An outside tool server Albert can use, over the Model Context Protocol |
| **Memory** | `.albertcode/memory.md`: what Albert has learned about a repository |
| **Mode** | How plain requests are handled: Governed, Direct (ask each write or auto) or Ask only |
| **Pace** | *thorough* (independent reviews on every change) or *fast* (none) |
| **Planned** | On the System map, but not in the code yet (dashed) |
| **Plugin** | Commands, agents and MCP servers in one shareable folder. See [Plugins](plugins.md) |
| **Preview** | Your app, run with one command, beside the chat |
| **Ready line** | What a part with no port prints when it is ready, such as `worker ready` |
| **Recommendation** | Something Albert suggests about your design (required, recommended or optional), with why and what it changes. You accept, change, put off or reject it; see [Recommendations](system.md#recommendations-albert-recommends-you-decide) |
| **Release** | A commit recorded, and tagged `release-<environment>-<n>`, as what went out to an environment, after every check passed |
| **Repair** | Albert fixing a slice that failed its verification, from the evidence (at most three times) |
| **Requirement** | One thing the app must do, numbered R1, R2… in `.albertcode/requirements.json` |
| **Run settings** | How a part on the System map runs: its folder, start command, port, health route or ready line |
| **Runtime** | What **Start all** starts: every part of your app, wired together and watched |
| **Session** | One conversation. Nothing said in one reaches another |
| **Skill** | A project convention written down in `.albertcode/skills/`, which changes what the model is told |
| **Slice** | One thing a person can do, built from the screen to the data and back, and proven running before the next |
| **Stand-in** | A fake of an outside service, used in tests and until its integration slice makes it real |
| **Status (on the map)** | Where a part or connection stands, on evidence only: Planned, Building, Built, Connected, Testing, Verified or Failed. See [Statuses on the map](system.md#statuses-on-the-map) |
| **Task** | One change: its request, plan, build, checks, reviews and diff |
| **Tool (saved)** | One of your commands, saved so the model can call it by name |
| **Topic** | The thing a group of chats is about (a slice, a part, a test…), shown as one row in the sidebar |
| **Verified** | Proven: a browser journey that passed on the code as it is now went through it. The only status shown green |
| **Verify** | Start the app, check every part and walk the journeys in a browser: the proof a slice works |
