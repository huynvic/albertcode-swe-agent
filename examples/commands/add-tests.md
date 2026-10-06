---
description: Add tests for untested behaviour, following the project's conventions
agent: test-writer
mode: governed
argument-hint: <path>
---
Find behaviour in $ARGUMENTS that no test covers, starting with error handling and edge cases.
Add tests for it in the style, location and framework the project already uses. Do not change the
code under test. Run the new tests and report anything they reveal.
