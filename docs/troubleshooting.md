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
| The browser page says to open AlbertCode from your terminal | Run `albertcode --ui`. It signs your browser in. In 1.33.0 and 1.33.1, `albertcode --ui` itself opened this page: update to 1.33.2. |
| The uninstall command fails with `404` or can't download | Run `albertcode uninstall` instead (1.33.2 and later). It needs nothing from the internet. |
| Every task fails with "Internal Server Error" on Windows, in a project with `node_modules` | Fixed in 1.33.2. On older versions, turn on Developer Mode (Settings → System → For developers). |
| The installer says the package inside it is damaged | The download was cut short or altered. Download it again. |

Everything an installer run did is written to its log:

| System | Log |
|---|---|
| Windows | `%LOCALAPPDATA%\AlbertCode\install.log` |
| macOS, Linux | `~/.local/share/albertcode-installer/install.log` |

## Running

| Symptom | Fix |
|---|---|
| It says no model is connected | Run `/connect`, or **Connect a provider** in the browser or VS Code. |
| A model connects but tasks stall or fail early | The model may not handle tool calling well. Run `/test`, and see [Models](models.md#what-a-model-needs). |
| Tests don't run, or run with the wrong tool | Run `albertcode doctor` to see which build tools AlbertCode can find. Install the missing one, or put it on your PATH. |
| Acceptance is refused | A file the change touches was edited after the task started. Look at your edits, then run the task again. |
| After updating, your provider is no longer connected | Saved keys are cleared when a new version first starts. Run `/connect` again. |
| The service seems stuck | Run `albertcode stop`, then `albertcode` again. |
| VS Code can't reach the service | Run `albertcode` once in a terminal to start the service, then reload the window. |
