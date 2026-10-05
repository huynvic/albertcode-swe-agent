#!/usr/bin/env python3
"""Release gate: scan this repository, including its whole Git history, before anything is pushed.

    python3 scripts/release_gate.py

Looks for credentials, private keys, local paths, personal email addresses, files that should never
be published (packages, builds, source maps, databases, logs, environment files), and oversized
files. Every tracked file, every file in every commit, every commit message and every commit
author is checked. A file deleted in a later commit is still in history, and still public once
pushed.

Maintainers can add terms that must never appear (internal names, private repository names) in a
file kept OUTSIDE this repository, one regular expression per line, and point to it with:

    ALBERTCODE_PRIVATE_DENYLIST=/path/outside/the/repo/denylist.txt python3 scripts/release_gate.py

That list is private by design: publishing it would publish the very names it protects.

Exits 0 when nothing is found, 1 when something is.
"""

from __future__ import annotations

import os
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

SECRETS: dict[str, re.Pattern[str]] = {
    "private key": re.compile(r"-----BEGIN [A-Z ]*PRIVATE KEY-----"),
    "AWS access key": re.compile(r"\b(?:AKIA|ASIA)[0-9A-Z]{16}\b"),
    "GitHub token": re.compile(r"\b(?:ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9]{36,}\b|\bgithub_pat_[A-Za-z0-9_]{60,}\b"),
    "OpenAI-style key": re.compile(r"\bsk-(?:proj-|ant-|or-)?[A-Za-z0-9_-]{20,}\b"),
    "Hugging Face token": re.compile(r"\bhf_[A-Za-z0-9]{30,}\b"),
    "Slack token": re.compile(r"\bxox[abprs]-[A-Za-z0-9-]{10,}\b"),
    "Google API key": re.compile(r"\bAIza[0-9A-Za-z_-]{35}\b"),
    "Stripe key": re.compile(r"\b(?:sk|rk)_live_[0-9A-Za-z]{20,}\b"),
    "JSON web token": re.compile(r"\beyJ[A-Za-z0-9_-]{10,}\.eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\b"),
    "assigned secret": re.compile(
        r"""(?i)\b(?:api[_-]?key|secret|token|password|passwd)\b\s*[:=]\s*["'][^"'\s]{12,}["']"""),
    "URL with a password": re.compile(r"\b[a-z][a-z0-9+.-]*://[^/\s:@]+:[^/\s:@]+@"),
}

LOCAL_PATHS = re.compile(
    r"(?<![\w.])(?:/home/(?!runner\b)[a-z_][\w-]*/|/Users/(?!runner\b)[A-Za-z][\w.-]*/|/(?:root)/|"
    r"[A-Za-z]:\\Users\\(?!runneradmin\b)[^\\\s]+\\|/tmp/[\w.-]+/)"
)
EMAIL = re.compile(r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b")
# Addresses that identify nobody: GitHub's no-reply and service addresses (on commits GitHub or
# Dependabot makes), and reserved example domains.
EMAIL_ALLOWED = re.compile(r"(?:@users\.noreply\.github\.com|^(?:noreply|support)@github\.com"
                           r"|@example\.(?:com|org|net|invalid))$", re.I)

FORBIDDEN_NAMES = re.compile(
    r"(?i)(?:^|/)(?:\.env(?:\.[\w.-]+)?|id_rsa|id_ed25519|\.netrc|\.npmrc|\.pypirc|credentials(?:\.json)?)$"
    r"|\.(?:pem|key|p12|pfx|jks|keystore|whl|vsix|egg|tar\.gz|zip|exe|msi|dmg|pkg|deb|rpm|so|dll|dylib|pyc|pyo"
    r"|map|db|sqlite|sqlite3|log|har|trace|core|dump|ipynb_checkpoints)$"
    r"|(?:^|/)(?:__pycache__|node_modules|\.venv|venv|dist|build)/"
)
# Example files are allowed to be called .env.example; nothing else in that family is.
FORBIDDEN_ALLOWED = re.compile(r"(?i)\.env\.example$")
BINARY_ALLOWED = re.compile(r"(?i)\.(?:png|gif|jpg|jpeg|webp|ico)$")
MAX_BYTES = 5 * 1024 * 1024


@dataclass(frozen=True)
class Finding:
    where: str
    what: str
    detail: str

    def __str__(self) -> str:
        return f"{self.where}: {self.what}: {self.detail}"


def git(*args: str) -> bytes:
    return subprocess.run(["git", *args], cwd=ROOT, check=True, capture_output=True).stdout


def private_terms() -> list[re.Pattern[str]]:
    location = os.environ.get("ALBERTCODE_PRIVATE_DENYLIST")
    if not location:
        return []
    path = Path(location).resolve()
    if path == ROOT or ROOT in path.parents:
        sys.exit("release gate: the private denylist must live outside this repository.")
    lines = path.read_text(encoding="utf-8").splitlines()
    return [re.compile(line.strip(), re.I) for line in lines if line.strip() and not line.lstrip().startswith("#")]


def scan_text(where: str, text: str, terms: list[re.Pattern[str]]) -> list[Finding]:
    found: list[Finding] = []
    for line_number, line in enumerate(text.splitlines(), 1):
        place = f"{where}:{line_number}"
        for name, pattern in SECRETS.items():
            match = pattern.search(line)
            if match:
                found.append(Finding(place, name, redact(match.group(0))))
        match = LOCAL_PATHS.search(line)
        if match:
            found.append(Finding(place, "local path", match.group(0)))
        for address in EMAIL.findall(line):
            if not EMAIL_ALLOWED.search(address):
                found.append(Finding(place, "email address", address))
        for term in terms:
            match = term.search(line)
            if match:
                found.append(Finding(place, "private term", match.group(0)))
    return found


def redact(value: str) -> str:
    return value[:6] + "…" if len(value) > 10 else "…"


def scan_path(where: str, path: str, terms: list[re.Pattern[str]]) -> list[Finding]:
    found: list[Finding] = []
    if FORBIDDEN_NAMES.search(path) and not FORBIDDEN_ALLOWED.search(path):
        found.append(Finding(where, "file that must not be published", path))
    for term in terms:
        if term.search(path):
            found.append(Finding(where, "private term in a file name", path))
    return found


def scan_blob(where: str, path: str, data: bytes, terms: list[re.Pattern[str]]) -> list[Finding]:
    found = scan_path(where, path, terms)
    if len(data) > MAX_BYTES:
        found.append(Finding(where, "file over 5 MB", f"{len(data) // 1024} KB"))
    if b"\0" in data[:8192]:
        if not BINARY_ALLOWED.search(path):
            found.append(Finding(where, "binary file", path))
        return found
    return found + scan_text(where, data.decode("utf-8", "replace"), terms)


def main() -> int:
    terms = private_terms()
    findings: list[Finding] = []

    # Every file in every commit (each distinct version is read once).
    seen: set[str] = set()
    objects = git("rev-list", "--all", "--objects").decode().splitlines()
    for entry in objects:
        sha, _, path = entry.partition(" ")
        if not path or sha in seen:
            continue
        kind = git("cat-file", "-t", sha).decode().strip()
        if kind != "blob":
            continue
        seen.add(sha)
        findings += scan_blob(f"{path} (blob {sha[:8]})", path, git("cat-file", "-p", sha), terms)

    # Every commit: who made it, and what its message says.
    log = git("log", "--all", "--format=%H%x00%an <%ae>%x00%cn <%ce>%x00%B%x1e").decode("utf-8", "replace")
    commits = [c for c in log.split("\x1e") if c.strip()]
    for record in commits:
        sha, author, committer, message = (record.strip("\n").split("\x00") + ["", "", "", ""])[:4]
        where = f"commit {sha[:8]}"
        for person in {author, committer}:
            for address in EMAIL.findall(person):
                if not EMAIL_ALLOWED.search(address):
                    findings.append(Finding(where, "personal email in commit metadata", person))
        findings += scan_text(f"{where} message", message, terms)

    # Files not yet committed are checked too, so the gate can run before the first commit.
    for path in git("ls-files", "--others", "--exclude-standard").decode().splitlines():
        findings += scan_blob(f"{path} (not committed)", path, (ROOT / path).read_bytes(), terms)

    unique = sorted(set(findings), key=str)
    print(f"release gate: {len(seen)} file versions, {len(commits)} commits"
          f"{', private denylist of ' + str(len(terms)) + ' terms' if terms else ', no private denylist'}")
    if not terms:
        print("release gate: WARNING: no private denylist given (ALBERTCODE_PRIVATE_DENYLIST); "
              "internal names were not checked")
    for finding in unique:
        print(f"  {finding}")
    if unique:
        print(f"release gate: {len(unique)} finding(s). Do not push.")
        return 1
    print("release gate: nothing found")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
