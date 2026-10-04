# Security policy

## Reporting a vulnerability

**Please don't report security problems in public issues or discussions.**

Report them privately through GitHub: open the repository's **Security** tab and choose
**Report a vulnerability**. Only the maintainers can see the report.

Please include:

- what the problem is, and what someone could do with it;
- the steps to reproduce it, the AlbertCode version (the installer prints it, and so does running
  it again with `--check`), and your operating system;
- whether it is already public anywhere.

Never include real keys, tokens or private code in a report. A redacted example is enough.

## What to expect

- We acknowledge reports within five working days.
- We keep you informed while we investigate and fix the problem.
- We credit you in the release notes when the fix ships, unless you prefer not to be named.

Please give us reasonable time to release a fix before you disclose the problem publicly.

## Supported versions

Security fixes go into the latest release. Updating is the fix: run the install command again.

## Scope

In scope:

- the AlbertCode SWE Agent application, in all three interfaces;
- the installers and bootstrap scripts in this repository and its releases;
- anything in this repository that could mislead a user into an unsafe action.

Out of scope:

- vulnerabilities in a model provider, MCP server or other third-party service;
- what a model you connected chooses to suggest, when AlbertCode's approvals and limits behaved as
  documented.

## How this repository is kept clean

Every change to this repository is scanned for credentials and private material before it is
published, and GitHub secret scanning and dependency alerts are enabled.
