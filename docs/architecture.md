# The Architecture page

**Architecture**, in the browser's **⋮** menu, draws what your app is made of and how its parts
connect, read from the repository's own files. Use it to learn a codebase, to check what a change
touches, or as the starting point of the [System page](system.md), which reads the same files.

## What you see

Three columns:

| Column | Holds |
|---|---|
| **People use** | Front ends and web pages |
| **It runs** | API servers and background jobs |
| **It relies on** | Databases, caches, sign-in, queues, file storage and outside services such as payments or email |

Select a part to see:

- **The files that put it on the map**, each one click from the code.
- **What it connects to**, with the file that shows each connection.
- **Its routes, pages and data models**, each with its file and line.

Click any file to open it in the side panel, beside the map.

## Nothing is guessed

Every box comes from a file that declares it, and a line is drawn only where a file shows the
connection:

| Read from | For |
|---|---|
| `package.json`, `pyproject.toml`, `requirements*.txt`, `go.mod` | The parts: frameworks, database drivers, sign-in libraries, job queues and outside services |
| `docker-compose.yml` | The databases, caches and queues that run beside the app; `depends_on` draws lines |
| `.env.example` | The outside services the app is set up for (names only; a real `.env` is never read) |
| The code | API routes (Express, Fastify, FastAPI, Flask, Django, Next.js route handlers), pages (Next.js, React Router) and data models (Prisma, SQLAlchemy, Django, SQLModel, Mongoose, Drizzle) |

Lines need evidence too: the front end calls the API where its code fetches from it; the back end uses
a database, a sign-in library or a service where the same manifest declares both.

A route on a FastAPI router or a Flask blueprint carries the router's prefix, so the list a router
serves at `""` is found where it is:

```python
router = APIRouter(prefix="/api/shipments")

@router.get("")           # GET /api/shipments
@router.get("/{ref}")     # GET /api/shipments/{ref}
```

A library that signs and checks tokens (PyJWT, jose, jsonwebtoken) is how the code reaches the sign-in
provider it also has, such as Okta, and is shown inside that box. Without a provider it is the app's
own sign-in, a box of its own.

A framework it does not recognise is listed as *found in a manifest*, not guessed at.

## Only the folder as it is now

The page reads only what the open folder holds now:

- at most 8,000 files, shallowest first;
- never what Git ignores, dependencies (`node_modules`, `.venv`, `vendor`…), build output (`dist`,
  `build`, `.next`, `target`…), caches, test reports, another checkout kept inside the folder (`.git`,
  `.worktrees`), or an editor's saved history (`.history`, `.idea`…);
- never old copies such as `file.py~`, `.orig`, `.bak` or `.swp`.

The map is reused only while every file it read is unchanged, so it follows your edits by itself.
**Read again** reads every file afresh.

## Examples

**Learning a new codebase.** Open the folder, then **Architecture**. Select the API to see its routes;
click a route to open its handler. Then ask in the chat: *"Walk me through what happens on
`POST /orders`."*

**Before a change.** Select the database to see which parts use it, then ask Albert for the change
knowing what it touches.

**Starting the System page.** Everything Architecture finds is already on the System map, where you
can connect each service, check it and build what is missing.
