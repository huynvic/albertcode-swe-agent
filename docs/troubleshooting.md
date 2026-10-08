# Troubleshooting

If none of these fit, [open an issue](https://github.com/huynvic/albertcode-swe-agent/issues/new/choose)
with what you ran, what you expected, and what happened. Leave out keys, tokens and private code.

## Installing

| Symptom | Fix |
|---|---|
| `albertcode: command not found` right after installing | Open a new terminal. The installer added the command to your PATH, and only new terminals pick that up. |
| The installer says pypi.org could not be reached | Check your connection. Behind a proxy, set `HTTPS_PROXY` and run it again. |
| A download fails with `invalid peer certificate` or `UnknownIssuer` | Your network inspects encrypted traffic. Current installers retry with your computer's certificates automatically. If yours didn't, update, or set `UV_NATIVE_TLS=1` and run it again. |
| Windows says it protected your PC | The installer isn't code-signed yet. Choose *More info* → *Run anyway*, after checking the checksum ([Installation](installation.md#manual-download)). |
| macOS says the installer "could not be executed because you do not have appropriate access privileges" | The browser saved it without permission to run. Download the `.zip` for your Mac from the release and open the installer inside it, or run `bash ~/Downloads/Install-AlbertCode-<version>-macos-arm64.command` in Terminal (`x86_64` on an Intel Mac). |
| macOS says it can't verify the installer is free of malware | The installers aren't signed yet. Open **System Settings → Privacy & Security**, click **Open Anyway**, then open the installer again. Or use the one-line install command, which doesn't trigger the warning. |
| The installer refuses to run under `sudo` on Linux | Run it as yourself. It installs for your user, and only asks for `sudo` if Git is missing. |
| Linux says "the release has no installer for Linux on … processors" | Only x86-64 is supported for now, not ARM. |
| The install fails on Alpine or another musl-based Linux | Not supported: AlbertCode needs a glibc-based distribution such as Ubuntu, Debian or Fedora. |
| PowerShell refuses to run the install command on Windows | Your organisation may block scripts. Download the `.cmd` installer from the release and double-click it instead. |
| Windows: "failed to remove directory …\Scripts: Access is denied (os error 5)" | AlbertCode was still open somewhere (another terminal, VS Code, its service), and Windows does not let a running program's files be replaced. Installers from 1.42.2 list those programs and close them after you say yes. With an older installer, close every terminal and VS Code window using AlbertCode, run `albertcode stop`, or restart Windows, then run the installer again. |
| **macOS:** "New folder" in the repository picker says the folder is read-only | You are at the top of the disk ("This computer") or in a system folder such as Applications. Choose **Home** or **Documents** in the picker and make the folder there. If macOS says "Operation not permitted" in Documents or Desktop, allow your terminal app in **System Settings → Privacy & Security → Files and Folders**. |
| The browser page says to open AlbertCode from your terminal | Run `albertcode --ui`. It signs your browser in. |
| The uninstall command fails with `404` or can't download | Run `albertcode uninstall` instead. It needs nothing from the internet. |
| The installer says the package inside it is damaged | The download was cut short or altered. Download it again. |

Everything an installer run did is written to its log:

| System | Log |
|---|---|
| Windows | `%LOCALAPPDATA%\AlbertCode\install.log` |
| macOS, Linux | `~/.local/share/albertcode-installer/install.log` |

## Running

| Symptom | Fix |
|---|---|
| System: a service shows "Nothing is listening at that address and port" | The service is not running, or the address or port is wrong. Start it, or press **Change connection** and fix the address. |
| System: "The key was rejected (401)" or "The password was not accepted" | The key or password is wrong or has been replaced. Make a new one in that service and press **Change connection**. |
| System: "Answers, sign-in not proven" | It answered, but the sign-in could not be shown to work, for example a Kafka broker, an MCP server that needs a browser sign-in (add it under Tools and skills), or a MySQL account that needs encryption the server does not offer. The reason is shown under the box. |
| System: a MongoDB address starting `mongodb+srv://` is refused | Use the standard address instead (`mongodb://host:27017/…`), shown in most hosted services under *Connect → Drivers*. |
| It says no model is connected | Run `/connect`, or **Connect a provider** in the browser or VS Code. |
| A model connects but tasks stall or fail early | The model may not handle tool calling well. Run `/test`, and see [Models](models.md#what-a-model-needs). |
| Tests don't run, or run with the wrong tool | Run `albertcode doctor` to see which build tools AlbertCode can find. Install the missing one, or put it on your PATH. |
| Acceptance is refused | A file the change touches was edited after the task started. Look at your edits, then run the task again. |
| After updating, your provider is no longer connected | Saved keys are cleared when a new version first starts. Run `/connect` again. |
| The service seems stuck | Run `albertcode stop`, then `albertcode` again. |
| VS Code says **Service unreachable** | Run `albertcode` once in a terminal to start the service, then run **Developer: Reload Window**. |
| A chat is not grouped with the others about the same thing | Only chats started from a page's button (Build, Repair, Fix with Albert, Ask Albert…) are filed under a topic; chats you start by typing are not. See [Chats about one thing](chat.md#chats-about-one-thing). |

## Building and running a system

| Symptom | Fix |
|---|---|
| The build button says **Describe the product** or **Plan the features** | Albert builds nothing until the product, its requirements and journeys are known. Describe it in a sentence, then **Plan the features** on the Plan tab. |
| A slice says it needs a part the map does not have yet | Open the **Plan** tab and **Add** the suggested part, or add it from the library. |
| **Start all**: a part says *Cannot run here* | AlbertCode could not tell how to start it. Give its folder a `dev` or `start` script, or open the part's **Details** → **How it runs** and give its start command. |
| A part says its packages are missing | Press **Install packages** on it: AlbertCode runs the install command it shows. |
| **Install packages** fails with a certificate or network error | Your network needs a proxy or its own certificates. Set `HTTPS_PROXY` (and `SSL_CERT_FILE`, `PIP_CERT` or `NODE_EXTRA_CA_CERTS` if your company gives you a certificate) in your terminal, run `albertcode stop`, then start `albertcode --ui` from that terminal. |
| A database in `docker-compose.yml` is not started | AlbertCode does not start containers. Run `docker compose up -d` yourself, then **Connect** the database on the map: its check decides when it is up. |
| Redis says it cannot be started | Install Redis (`redis-server`) and press **Start all** again, or connect a Redis you already run on the map. |
| A part is **Running** but not **Healthy** | Nothing proves it works: give it a health route (`/health`) or, for a worker, a ready line it prints, in **How it runs**. |
| A part is **Unhealthy** right after a change | Its code fails to load: read its log on the **Run** tab, or press **Fix with Albert** on it. The dev server picks up the fix by itself. |
| A part **Crashed** and stays stopped | It stopped three times within ten minutes. Read its log, fix the cause, then **Start**. |
| The app's address keeps showing *Starting…* | A part is still starting or waiting for a part it needs. The **Run** tab says which, and why. |
| **Verify** fails at *Walk every journey*: no browser test walks [R1] yet | The slice needs a browser test titled `[R1] …`. Build the slice (its request asks for one), or **Add a test** on the Requirements page. |
| The Build tab says *the code has changed since* | The last verification was of older code. Press **Verify** again. |
| **Roll back** says there is no checkpoint yet | A checkpoint is kept each time a slice passes its verification, and only in a Git repository. Run `git init` and commit, then verify a slice. |
| **Release** is refused | Something failed when it checked again, or you have files that are not committed. The checklist says which. |
