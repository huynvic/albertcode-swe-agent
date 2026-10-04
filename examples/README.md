# Examples

Custom commands and custom agents you can copy into your own repositories. Each is a single Markdown
file; [Extending](../docs/extending.md) explains the format.

| File | What it does |
|---|---|
| [commands/review.md](commands/review.md) | `/review <file>`: correctness review of one file, without changing it |
| [commands/fix-test.md](commands/fix-test.md) | `/fix-test <test>`: find why a test fails and fix the cause, not the test |
| [commands/explain.md](commands/explain.md) | `/explain <path>`: how a module works, for someone new to it |
| [commands/add-tests.md](commands/add-tests.md) | `/add-tests <path>`: tests for untested behaviour, following the project's conventions |
| [agents/reader.md](agents/reader.md) | An agent that reads and reports, and can never edit |
| [agents/test-writer.md](agents/test-writer.md) | An agent that may only add and change tests |

## Using them

For one repository, copy the files into `.albertcode/commands/` or `.albertcode/agents/` and commit
them, so your team has them too.

```bash
mkdir -p .albertcode/commands .albertcode/agents
cp examples/commands/review.md .albertcode/commands/
cp examples/agents/reader.md   .albertcode/agents/
```

For yourself across every repository, copy them into `commands/` or `agents/` in your AlbertCode
settings folder. [PRIVACY.md](../PRIVACY.md#what-is-kept-on-your-machine) lists where that folder is
on each system.

Have one worth sharing? See [CONTRIBUTING.md](../CONTRIBUTING.md).
