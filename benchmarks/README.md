# Benchmarks

This page is where AlbertCode SWE Agent's evaluation results will be published. Every result follows
the rules below, so you can judge how far to trust it.

## Published results

| Benchmark | Model | Tasks | Resolved | Status | Report |
|---|---|---|---|---|---|
| SWE-bench Pro V2, HARD-51 (all 51 tasks) | A frontier hosted model | 51 | 39 (76.5%) | Self-reported | [Report](results/swe-bench-pro-hard51-2026-09-frontier-model/REPORT.md) |

## Rules for every result

1. **Every number has evidence.** A result is published only with its run date, the AlbertCode
   version, the model and its settings, the task list, and the per-task outcomes.
2. **Self-reported and independently verified are kept apart.**
   - **Self-reported**: we ran it. The report says so in its title and in the table above.
   - **Independently verified**: someone outside the AlbertCode team ran it, or checked our
     outputs against the benchmark's official harness. The report names who, and links their
     record.
3. **The whole run counts.** Tasks that errored, timed out or were skipped count as unresolved. No
   task is quietly dropped, and no attempt is re-run until it passes, unless the report says so and
   gives both numbers.
4. **Cost and time are reported** wherever we have them: model spend, tokens, and wall-clock time
   per task.
5. **Comparisons are like-for-like.** A comparison with another system names its source and date,
   and uses the same benchmark split and scoring. Otherwise there is no comparison.
6. **Limitations are stated**, including how the run differs from the benchmark's official
   protocol.

[methodology/](methodology/README.md) has the full reporting standard,
[results/](results/README.md) holds the reports, and [reproduction/](reproduction/README.md) explains
how to check a result yourself.
