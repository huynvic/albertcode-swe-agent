# SWE-bench Pro HARD-51 — September 2026

> **Status: SELF-REPORTED.** The AlbertCode developer ran and graded this evaluation. It has not
> been run or verified by Scale AI, by the SWE-bench Pro maintainers, or by anyone else.

| | |
|---|---|
| Benchmark, version, split | SWE-bench Pro V2, HARD-51: all 51 tasks (`ScaleAI/SWE-bench_Pro`, config `hard`, revision `2d52cb3`) |
| AlbertCode version | 1.9.0 with later changes, frozen before the run and unchanged during it |
| Model, provider, settings | A frontier model, used through its provider's hosted API at **high** reasoning effort, set by the evaluation harness (AlbertCode's default with this model uses less). This report doesn't name the model or its provider |
| Mode and limits per task | Direct mode: AlbertCode works in the task's code, runs its checks and hands over the change. One attempt, 50 minutes. No web lookup, no person involved, and each task started fresh |
| Tasks attempted | 51 of 51 |
| **Resolved** | **39 / 51 (76.5%)**, 95% interval 63.2% to 86.0% |
| Unresolved | 12: 10 changes delivered but failing the tests, 2 attempts that ended without a change |
| Runtime | Median 8.5 min per task; 7.9 hours in total |
| Tokens | 146.6 M input, 1.1 M output in total |
| Cost | US$30.63 in total, US$0.79 per resolved task, at the provider's list price. This is an upper bound: cached input isn't separated in the records, so all input is priced at the full rate |
| Run date | 30 September 2026 (final re-grades completed 1 October) |

## What HARD-51 is

SWE-bench Pro is Scale AI's benchmark of real software-engineering work. Each task is a real
issue or feature in a professional open-source project in Go, Python, JavaScript or TypeScript, and
the change often spans several files. A task counts as resolved only if the project's own tests,
which the agent never sees, pass afterwards.

HARD-51 is its hardest part. The benchmark's README defines it as the tasks that at least two of
five frontier model families failed under the V2 protocol. That is a statement of difficulty, not a
score to compare against.

## Results by set

Some of these tasks had been seen before this run, while AlbertCode was being developed and tested.
The results are split so you can weigh them; **the 22 tasks held out from all development are the
fairest measure.**

| Set | Tasks | Resolved | Rate | 95% interval |
|---|---|---|---|---|
| All 51 tasks | 51 | 39 | 76.5% | 63.2% to 86.0% |
| **Held out from all development** | **22** | **14** | **63.6%** | **43.0% to 80.3%** |
| Seen before this run | 29 | 25 | 86.2% | 69.4% to 94.5% |

**Delivery precision.** Of the 49 changes AlbertCode handed over, 39 pass (80%).

## Method

- **Fixed in advance.** The protocol, the task order and the version were committed before the
  first attempt, with their checksums recorded. Every later change to the protocol was dated and
  recorded before the results it could affect.
- **One attempt per task**, in a fixed order unrelated to difficulty.
- **Infrastructure losses re-run, never results.** Five tasks had an attempt lost to something
  outside AlbertCode: a machine or container restart, a workspace fault in the harness, or the model
  provider failing every retry of a request. As the protocol allows, each was recorded with its cause
  and run again. No attempt was ever re-run because of its result.
- **Graded with each task's official tests**, in environments rebuilt from the upstream projects.
  Each environment was first checked: the reference solution must pass and an empty change must
  fail.
- **Graded twice.** Every delivered change was graded again in a freshly built environment. Both
  grades agreed on all 49.
- **Only the handed-over change counts.** Work left unfinished at the time limit counts as
  unresolved.

### How this differs from the official protocol

- The grading environments were rebuilt from upstream, not Scale AI's official V2 images. A test
  that depends on an installed version can behave differently.
- The agent had no web lookup, no download commands and no Git history, but the network wasn't cut
  off: a project's own build and test commands could fetch its dependencies.
- The time limit was enforced by our harness, not the official one.
- One run, not repeated.

## Limitations

- **Self-reported.** Until the delivered changes are re-graded on the official images by someone
  independent, treat this as our own measurement.
- **More than half of the tasks had been seen before.** The 22 held-out tasks are the fairest
  measure, and 22 is a small sample.
- **High reasoning effort was set by the harness.** It isn't AlbertCode's default with this model,
  which uses less, so results with the default settings may differ.
- **One model, one version.** The result is for the AlbertCode build described above with this model. Later versions and other models will score differently.
- **Small sample.** With 51 tasks, the 95% interval is wide: 63% to 86%.
- **No comparison is made.** Other systems' HARD-51 numbers were produced under different
  settings, so this report doesn't compare against them.

## Evidence

- [`outcomes.csv`](outcomes.csv): one row per task. It gives the task, its repository and language,
  whether it was held out, the outcome, whether it was resolved and the time taken.
- The delivered changes are kept in the format the official V2 re-grader reads, so an independent
  grader can re-grade them on the official images. See [reproduction](../../reproduction/README.md).
