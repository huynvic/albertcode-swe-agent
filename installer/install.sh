#!/bin/sh
# AlbertCode SWE Agent bootstrap for macOS and Linux.
#
#   curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh
#   curl -fsSL .../install.sh | sh -s -- --check
#
# It downloads the installer for this system from a release of this repository, checks it against
# that release's SHA256SUMS, and runs it. It changes nothing itself: the installer checks the
# machine, shows its plan and asks "Proceed? [Y/N]" before it changes anything.
#
# --uninstall removes AlbertCode instead, after showing what it will remove and asking.
#
# Plain POSIX sh, because `curl ... | sh` may run it with dash or another small shell.

set -eu

REPOSITORY="huynvic/albertcode-swe-agent"
# A mirror of the releases, laid out as GitHub lays them out (latest/download/<file> and
# download/v<version>/<file>). Unset means this repository's releases.
DOWNLOADS="${ALBERTCODE_DOWNLOAD_BASE:-https://github.com/$REPOSITORY/releases}"

if [ -t 1 ]; then
    GREEN=$(printf '\033[32m'); YELLOW=$(printf '\033[33m'); RED=$(printf '\033[31m'); OFF=$(printf '\033[0m')
else
    GREEN=''; YELLOW=''; RED=''; OFF=''
fi

say() { printf '%s\n' "$1"; }
warn() { printf '%s%s%s\n' "$YELLOW" "$1" "$OFF"; }
fail() {
    printf '%s%s%s\n' "$RED" "AlbertCode bootstrap: $1" "$OFF" >&2
    [ -n "${2:-}" ] && printf '%s\n' "$2" >&2
    exit 1
}

usage() {
    cat <<'EOF'
AlbertCode SWE Agent bootstrap

Usage: install.sh [options]

  (no options)       check this machine, show the plan, ask, then install or update
  --check            only check and show the plan
  --yes              install without asking (scripts, CI)
  --reinstall        install again even when this version is already installed
  --version X.Y.Z    install that release instead of the latest
  --uninstall        remove AlbertCode (asks first; keeps your settings)
  --help             show this help

Through a pipe, pass options after `sh -s --`:
  curl -fsSL https://raw.githubusercontent.com/huynvic/albertcode-swe-agent/main/installer/install.sh | sh -s -- --check
EOF
}

# -- arguments -------------------------------------------------------------------------------- #

VERSION=""
UNINSTALL=0
YES=0
CHECK=0
PASS=""          # options handed to the installer, already validated
while [ $# -gt 0 ]; do
    case "$1" in
        --version)
            [ $# -ge 2 ] || fail "--version needs a version, for example --version 1.42.1"
            VERSION="$2"; shift ;;
        --version=*) VERSION="${1#--version=}" ;;
        --uninstall) UNINSTALL=1 ;;
        --yes|-y) YES=1; PASS="$PASS --yes" ;;
        --check) CHECK=1; PASS="$PASS --check" ;;
        --reinstall) PASS="$PASS --reinstall" ;;
        --help|-h) usage; exit 0 ;;
        *) usage >&2; fail "unknown option: $1" ;;
    esac
    shift
done
VERSION="${VERSION#v}"
case "$VERSION" in
    ''|[0-9]*) ;;
    *) fail "not a version: $VERSION" ;;
esac
case "$VERSION" in
    *[!0-9A-Za-z.+-]*) fail "not a version: $VERSION" ;;
esac

# -- this machine ----------------------------------------------------------------------------- #

case "$(uname -s)" in
    Darwin) SYSTEM=macOS; SUFFIX="command"; PLATFORM="macos" ;;
    Linux) SYSTEM=Linux; SUFFIX="sh"; PLATFORM="linux" ;;
    MINGW*|MSYS*|CYGWIN*)
        fail "this is the macOS and Linux bootstrap." \
             "On Windows, run in PowerShell: irm https://raw.githubusercontent.com/$REPOSITORY/main/installer/install.ps1 | iex" ;;
    *) fail "$(uname -s) is not supported. AlbertCode runs on Windows, macOS and Linux." ;;
esac

# The processor, as installer names spell it. A Mac with Apple silicon is arm64 even when this shell
# runs under Rosetta, where uname says x86_64.
PROCESSOR="$(uname -m)"
case "$PROCESSOR" in arm64|aarch64) [ "$PLATFORM" = linux ] && PROCESSOR=aarch64 || PROCESSOR=arm64 ;; amd64) PROCESSOR=x86_64 ;; esac
if [ "$PLATFORM" = macos ] && [ "$(sysctl -n hw.optional.arm64 2>/dev/null)" = 1 ]; then PROCESSOR=arm64; fi

if command -v curl >/dev/null 2>&1; then
    fetch() { curl -fsSL --retry 3 --proto '=https,file' -o "$2" "$1"; }
elif command -v wget >/dev/null 2>&1; then
    fetch() { wget -q --tries=3 -O "$2" "$1"; }
else
    fail "this needs curl or wget to download the installer."
fi

if command -v sha256sum >/dev/null 2>&1; then
    sha256_of() { sha256sum "$1" | cut -d ' ' -f 1; }
elif command -v shasum >/dev/null 2>&1; then
    sha256_of() { shasum -a 256 "$1" | cut -d ' ' -f 1; }
else
    fail "this needs sha256sum or shasum to check the download."
fi

# The answer to a question comes from the terminal, not from stdin: under `curl ... | sh`,
# stdin is this script.
have_terminal() { [ -r /dev/tty ] && (exec </dev/tty) 2>/dev/null; }

ask_yes_no() {
    printf '%s [Y/N] ' "$1"
    answer=""
    read -r answer </dev/tty || answer=""
    case "$answer" in [Yy]|[Yy][Ee][Ss]) return 0 ;; *) return 1 ;; esac
}

WORK="$(mktemp -d "${TMPDIR:-/tmp}/albertcode-bootstrap.XXXXXX")"
trap 'rm -rf "$WORK"' EXIT
trap 'exit 130' INT TERM

# -- uninstall -------------------------------------------------------------------------------- #

uninstall() {
    root="${HOME:?}/.local/share/albertcode-installer"
    if [ "$SYSTEM" = macOS ]; then settings="$HOME/Library/Application Support/AlbertCode SWE Agent"
    else settings="${XDG_DATA_HOME:-$HOME/.local/share}/AlbertCode SWE Agent"; fi

    uv=""
    if [ -x "$root/bin/uv" ]; then uv="$root/bin/uv"
    elif command -v uv >/dev/null 2>&1; then uv="$(command -v uv)"; fi
    with_uv=0
    if [ -n "$uv" ] && "$uv" tool list 2>/dev/null | grep -q '^albertcode '; then with_uv=1; fi
    with_pipx=0
    if command -v pipx >/dev/null 2>&1 && pipx list --short 2>/dev/null | grep -q '^albertcode '; then with_pipx=1; fi
    launcher="$(command -v albertcode 2>/dev/null || true)"

    say ""
    say "AlbertCode uninstall"
    say "Nothing is changed until you say so."
    say ""
    if [ $with_uv = 0 ] && [ $with_pipx = 0 ] && [ ! -d "$root" ]; then
        if [ -n "$launcher" ]; then
            say "AlbertCode is at $launcher, but it was not installed by the AlbertCode installer, uv or pipx."
            say "Remove it the way it was installed."
        else
            say "AlbertCode is not installed."
        fi
        return 0
    fi

    say "Will do"
    step=1
    if [ -n "$launcher" ]; then say "  $step. Stop the AlbertCode service, if it is running."; step=$((step + 1)); fi
    if [ $with_uv = 1 ]; then say "  $step. Remove AlbertCode (installed with uv)."; step=$((step + 1)); fi
    if [ $with_pipx = 1 ]; then say "  $step. Remove AlbertCode (installed with pipx)."; step=$((step + 1)); fi
    if [ -d "$root" ]; then say "  $step. Remove the installer's files in $root."; step=$((step + 1)); fi
    say ""
    say "Kept: your settings, saved keys and task history, in $settings."
    say "Delete that folder yourself if you want them gone."
    say ""

    if [ $CHECK = 1 ]; then return 0; fi
    if [ $YES = 0 ]; then
        have_terminal || fail "no terminal to ask in. Run it in a terminal, or add --yes."
        if ! ask_yes_no "Proceed?"; then say "Nothing was changed."; return 0; fi
    fi

    if [ -n "$launcher" ]; then "$launcher" stop >/dev/null 2>&1 || true; fi
    if [ $with_uv = 1 ]; then
        "$uv" tool uninstall albertcode >/dev/null 2>&1 || fail "uv could not remove AlbertCode." "Try: $uv tool uninstall albertcode"
        say "  Removed AlbertCode."
    fi
    if [ $with_pipx = 1 ]; then
        pipx uninstall albertcode >/dev/null 2>&1 || fail "pipx could not remove AlbertCode." "Try: pipx uninstall albertcode"
        say "  Removed AlbertCode (pipx)."
    fi
    if [ -d "$root" ]; then
        rm -rf "${root:?}"
        say "  Removed $root."
    fi

    left="$(command -v albertcode 2>/dev/null || true)"
    if [ -n "$left" ] && [ -e "$left" ]; then
        warn "albertcode is still at $left. It was installed some other way; remove it the way it was installed."
    else
        printf '%s%s%s\n' "$GREEN" "AlbertCode is uninstalled." "$OFF"
    fi
}

if [ $UNINSTALL = 1 ]; then
    uninstall
    exit 0
fi

# -- download and check ----------------------------------------------------------------------- #

if [ -n "$VERSION" ]; then
    SUMS_URL="$DOWNLOADS/download/v$VERSION/SHA256SUMS"
else
    SUMS_URL="$DOWNLOADS/latest/download/SHA256SUMS"
fi

say "Finding the AlbertCode release for $SYSTEM..."
if ! fetch "$SUMS_URL" "$WORK/SHA256SUMS" 2>/dev/null; then
    if [ -n "$VERSION" ]; then
        fail "release $VERSION was not found." "Releases: https://github.com/$REPOSITORY/releases"
    fi
    fail "no release could be downloaded." \
         "Check your connection (behind a proxy, set HTTPS_PROXY), or see https://github.com/$REPOSITORY/releases"
fi

# A line is "<sha256>  <file>" (a leading * marks binary mode in some tools). An installer built for
# this processor is preferred; one without a processor in its name runs on any.
installer_line() {
    grep -E "^[0-9a-fA-F]{64} [ *]?Install-AlbertCode-[0-9][0-9A-Za-z.+]*$1\.$SUFFIX\$" "$WORK/SHA256SUMS" | head -n 1 || true
}
LINE="$(installer_line "-$PLATFORM-$PROCESSOR")"
[ -n "$LINE" ] || LINE="$(installer_line "")"
if [ -z "$LINE" ]; then
    if grep -q "Install-AlbertCode-.*-$PLATFORM-" "$WORK/SHA256SUMS"; then
        fail "the release has no installer for $SYSTEM on $PROCESSOR processors."
    fi
    fail "the release has no installer for $SYSTEM."
fi
EXPECTED="$(printf '%s' "$LINE" | cut -d ' ' -f 1 | tr 'A-F' 'a-f')"
FILE="$(printf '%s' "$LINE" | sed -E 's/^[0-9a-fA-F]{64} [ *]?//')"
FOUND_VERSION="${FILE#Install-AlbertCode-}"
FOUND_VERSION="${FOUND_VERSION%."$SUFFIX"}"
FOUND_VERSION="${FOUND_VERSION%-"$PLATFORM"-*}"
if [ -n "$VERSION" ] && [ "$FOUND_VERSION" != "$VERSION" ]; then
    fail "release $VERSION lists an installer for $FOUND_VERSION; refusing the mismatch."
fi

say "Downloading $FILE..."
fetch "$DOWNLOADS/download/v$FOUND_VERSION/$FILE" "$WORK/$FILE" ||
    fail "the installer could not be downloaded." "Try again, or download it from https://github.com/$REPOSITORY/releases"
ACTUAL="$(sha256_of "$WORK/$FILE")"
if [ "$ACTUAL" != "$EXPECTED" ]; then
    fail "the downloaded installer does not match its published checksum. Nothing was run." \
         "Expected $EXPECTED, got $ACTUAL. Try again; if it keeps happening, report it: https://github.com/$REPOSITORY/security"
fi
say "Checked $FILE against the release's SHA-256."

# -- hand over -------------------------------------------------------------------------------- #

# The installer asks its own question; give it the terminal to read the answer from.
# shellcheck disable=SC2086  # PASS holds only the fixed options accepted above
if [ $YES = 1 ] || [ $CHECK = 1 ]; then
    bash "$WORK/$FILE" $PASS
elif have_terminal; then
    bash "$WORK/$FILE" $PASS </dev/tty
else
    fail "no terminal to ask in. Run it in a terminal, or add --yes (sh -s -- --yes)."
fi
