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
| **Boundary** | The limits a repository's [contract](contract.md) sets; also the button on the repository card |
| **Command (custom)** | A message you send often, used by name: `/review src/cart.py` |
| **Connector** | A ready-made MCP server you add in a couple of answers |
| **Contract (repository)** | `albertcode.contract.toml`: what AlbertCode may do in a repository. See [The contract](contract.md) |
| **Direct** | The mode that works in your real files, asking before each write or applying them as they come |
| **Evidence** | What a task leaves: the plan, the commands and results, the checks, the reviews, the diff and the approvals |
| **Evidence ledger** | The record of everything AlbertCode did, each entry linked to the one before, so a change is detected |
| **Governed** | The default mode: plan, approval, isolated build, checks, reviews, approval, apply |
| **Isolated copy** | The private copy of your repository a governed task works in, so your files stay untouched until you accept |
| **Journey** | The steps a person takes through a feature, which a browser test walks |
| **Language checks** | The checker each edited file is run through (pyright, gopls…), so Albert fixes what its edit broke |
| **MCP server** | An outside tool server Albert can use, over the Model Context Protocol |
| **Memory** | `.albertcode/memory.md`: what Albert has learned about a repository |
| **Mode** | How plain requests are handled: Governed, Direct (ask each write or auto) or Ask only |
| **Pace** | *thorough* (independent reviews on every change) or *fast* (none) |
| **Plugin** | Commands, agents and MCP servers in one shareable folder. See [Plugins](plugins.md) |
| **Preview** | Your app, run with one command, beside the chat |
| **Requirement** | One thing the app must do, numbered R1, R2… in `.albertcode/requirements.json` |
| **Session** | One conversation. Nothing said in one reaches another |
| **Skill** | A project convention written down in `.albertcode/skills/`, which changes what the model is told |
| **Task** | One change: its request, plan, build, checks, reviews and diff |
| **Tool (saved)** | One of your commands, saved so the model can call it by name |
| **Topic** | The thing a group of chats is about (a requirement, a test…), shown as one row in the sidebar |
