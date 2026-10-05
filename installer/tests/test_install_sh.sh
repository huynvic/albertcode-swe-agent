#!/bin/sh
# Tests for installer/install.sh, against a fake release laid out as GitHub lays one out.
#
#   sh installer/tests/test_install_sh.sh
#
# The fake installers only print what they were given; nothing is installed.

set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
BOOTSTRAP="$HERE/../install.sh"
WORK="$(mktemp -d "${TMPDIR:-/tmp}/albertcode-bootstrap-test.XXXXXX")"
trap 'rm -rf "$WORK"' EXIT
FAILED=0

case "$(uname -s)" in Darwin) SUFFIX="command" ;; *) SUFFIX="sh" ;; esac
if command -v sha256sum >/dev/null 2>&1; then sum() { sha256sum "$1" | cut -d ' ' -f 1; }
else sum() { shasum -a 256 "$1" | cut -d ' ' -f 1; }; fi

check() {  # check <name> <condition...>
    name="$1"; shift
    if "$@"; then printf 'ok    %s\n' "$name"; else printf 'FAIL  %s\n' "$name"; FAILED=1; fi
}
# shellcheck disable=SC2317,SC2329  # called through check
contains() { printf '%s' "$1" | grep -qF -- "$2"; }

# release <version>: a release folder with an installer that reports its version and arguments.
release() {
    dir="$WORK/mirror/download/v$1"
    mkdir -p "$dir"
    file="Install-AlbertCode-$1.$SUFFIX"
    printf '#!/bin/bash\necho "fake installer %s args: $*"\n' "$1" > "$dir/$file"
    printf '%s  %s\n' "$(sum "$dir/$file")" "$file" > "$dir/SHA256SUMS"
}
release 9.8.6
release 9.8.7
mkdir -p "$WORK/mirror/latest/download"
cp "$WORK/mirror/download/v9.8.7/SHA256SUMS" "$WORK/mirror/latest/download/SHA256SUMS"
MIRROR="file://$WORK/mirror"

run() { ALBERTCODE_DOWNLOAD_BASE="$MIRROR" sh "$BOOTSTRAP" "$@" 2>&1; }

out="$(run --yes)"
check "installs the latest release" contains "$out" "fake installer 9.8.7 args: --yes"
check "checks it against the release's SHA-256" contains "$out" "Checked Install-AlbertCode-9.8.7.$SUFFIX"

out="$(run --check --version 9.8.6)"
check "--version picks that release" contains "$out" "fake installer 9.8.6 args: --check"

out="$(run --yes --version v9.8.6)"
check "a leading v is accepted" contains "$out" "fake installer 9.8.6"

# The script arrives on standard input, as it does from `curl ... | sh`.
out="$(ALBERTCODE_DOWNLOAD_BASE="$MIRROR" sh -s -- --yes --reinstall < "$BOOTSTRAP" 2>&1)"
check "works through a pipe, with options after sh -s --" contains "$out" "fake installer 9.8.7 args: --yes --reinstall"

# A changed installer is refused before it runs.
cp -r "$WORK/mirror" "$WORK/tampered"
printf 'echo "TAMPERED"\n' >> "$WORK/tampered/download/v9.8.7/Install-AlbertCode-9.8.7.$SUFFIX"
out="$(ALBERTCODE_DOWNLOAD_BASE="file://$WORK/tampered" sh "$BOOTSTRAP" --yes 2>&1)"; code=$?
check "a changed installer is refused" contains "$out" "does not match its published checksum"
# shellcheck disable=SC2016  # $1 is expanded by the inner sh
check "a changed installer is never run" sh -c '! printf "%s" "$1" | grep -q TAMPERED' _ "$out"
check "and the bootstrap fails" [ "$code" -ne 0 ]

out="$(ALBERTCODE_DOWNLOAD_BASE="file://$WORK/nothing" sh "$BOOTSTRAP" --yes 2>&1)"; code=$?
check "no release: says so" contains "$out" "no release could be downloaded"
check "no release: fails" [ "$code" -ne 0 ]

out="$(run --yes --version 1.0.0)"
check "an unknown version: says so" contains "$out" "release 1.0.0 was not found"

out="$(run --yes --version '1.0;rm')"
check "a malformed version is refused" contains "$out" "not a version"

out="$(run --frobnicate)"; code=$?
check "an unknown option is refused" contains "$out" "unknown option: --frobnicate"

if command -v setsid >/dev/null 2>&1; then
    out="$(ALBERTCODE_DOWNLOAD_BASE="$MIRROR" setsid sh "$BOOTSTRAP" </dev/null 2>&1)"
    check "with no terminal to ask in, it stops instead of guessing" contains "$out" "no terminal to ask in"
    # shellcheck disable=SC2016  # $1 is expanded by the inner sh
    check "and runs nothing" sh -c '! printf "%s" "$1" | grep -q "fake installer"' _ "$out"
fi

# -- an installer per processor ------------------------------------------------------------- #

case "$(uname -s)" in Darwin) PLATFORM="macos" ;; *) PLATFORM="linux" ;; esac
case "$(uname -m)" in arm64|aarch64) [ "$PLATFORM" = linux ] && HERE_CPU=aarch64 || HERE_CPU=arm64; OTHER_CPU=x86_64 ;;
                      *) HERE_CPU=x86_64; [ "$PLATFORM" = linux ] && OTHER_CPU=aarch64 || OTHER_CPU=arm64 ;; esac
[ "$PLATFORM" = macos ] && [ "$(sysctl -n hw.optional.arm64 2>/dev/null)" = 1 ] && { HERE_CPU=arm64; OTHER_CPU=x86_64; }

# per_cpu <mirror> <version> <cpu...>: a release with one installer per processor.
per_cpu() {
    root="$1"; version="$2"; shift 2
    dir="$WORK/$root/download/v$version"; mkdir -p "$dir" "$WORK/$root/latest/download"; : > "$dir/SHA256SUMS"
    for cpu in "$@"; do
        file="Install-AlbertCode-$version-$PLATFORM-$cpu.$SUFFIX"
        printf '#!/bin/bash\necho "fake installer %s for %s args: $*"\n' "$version" "$cpu" > "$dir/$file"
        printf '%s  %s\n' "$(sum "$dir/$file")" "$file" >> "$dir/SHA256SUMS"
    done
    cp "$dir/SHA256SUMS" "$WORK/$root/latest/download/SHA256SUMS"
}
per_cpu cpus 9.9.0 "$OTHER_CPU" "$HERE_CPU"
out="$(ALBERTCODE_DOWNLOAD_BASE="file://$WORK/cpus" sh "$BOOTSTRAP" --yes 2>&1)"
check "picks the installer built for this processor" contains "$out" "fake installer 9.9.0 for $HERE_CPU args: --yes"

per_cpu othercpu 9.9.1 "$OTHER_CPU"
out="$(ALBERTCODE_DOWNLOAD_BASE="file://$WORK/othercpu" sh "$BOOTSTRAP" --yes 2>&1)"; code=$?
check "with none for this processor, says so" contains "$out" "no installer for"
# shellcheck disable=SC2016  # $1 is expanded by the inner sh
check "and runs nothing" sh -c '! printf "%s" "$1" | grep -q "fake installer"' _ "$out"

# -- uninstall -------------------------------------------------------------------------------- #

FAKE_HOME="$WORK/home"
ROOT="$FAKE_HOME/.local/share/albertcode-installer"
mkdir -p "$ROOT/bin" "$ROOT/packages" "$FAKE_HOME/bin" "$FAKE_HOME/.local/share/AlbertCode SWE Agent"
echo keep > "$FAKE_HOME/.local/share/AlbertCode SWE Agent/settings.json"
cat > "$ROOT/bin/uv" <<EOF
#!/bin/sh
case "\$*" in
    "tool list") [ -e "$FAKE_HOME/bin/albertcode" ] && echo "albertcode v9.8.7" ;;
    "tool uninstall albertcode") rm -f "$FAKE_HOME/bin/albertcode" ;;
esac
exit 0
EOF
cat > "$FAKE_HOME/bin/albertcode" <<EOF
#!/bin/sh
echo "\$*" >> "$WORK/albertcode-calls"
EOF
chmod +x "$ROOT/bin/uv" "$FAKE_HOME/bin/albertcode"
uninstall() { HOME="$FAKE_HOME" XDG_DATA_HOME="" PATH="$FAKE_HOME/bin:/usr/bin:/bin" sh "$BOOTSTRAP" --uninstall "$@" 2>&1; }

out="$(uninstall --check)"
check "uninstall --check shows the plan" contains "$out" "Remove AlbertCode (installed with uv)."
check "and changes nothing" [ -d "$ROOT" ]

out="$(uninstall --yes)"
check "uninstall stops the service" grep -qx stop "$WORK/albertcode-calls"
check "uninstall removes AlbertCode" [ ! -e "$FAKE_HOME/bin/albertcode" ]
check "uninstall removes the installer's files" [ ! -e "$ROOT" ]
check "uninstall keeps the settings" [ -f "$FAKE_HOME/.local/share/AlbertCode SWE Agent/settings.json" ]
check "and says where they are" contains "$out" "Kept: your settings"
check "and that it is done" contains "$out" "AlbertCode is uninstalled."

out="$(uninstall --yes)"
check "uninstalling again: nothing to do" contains "$out" "AlbertCode is not installed."

if [ "$FAILED" = 0 ]; then echo "all passed"; else echo "some tests failed"; fi
exit "$FAILED"
