# Methodology

How a benchmark run is done and reported. A result that doesn't meet this standard isn't published.

## Before the run

- **Fix the setup and record it**: the AlbertCode version, the model and provider, sampling
  settings, the mode (governed, fast or direct), and any time or cost limits per task.
- **Fix the task list** before the first task runs. The full benchmark or an official split is
  preferred. A subset needs a stated selection rule (for example, a random sample with its seed),
  chosen before any result is seen.
- **Use the benchmark's own harness** to decide what counts as resolved. AlbertCode's own checks are
  not the score.
- **No benchmark-specific tuning.** The product that is measured is the product that ships.

## During the run

- Each task starts from a clean checkout, with no access to the benchmark's hidden tests or gold
  patches.
- Approvals are given automatically and recorded. The report says so, because a person using
  AlbertCode would approve each step.
- Failures of any kind (model errors, timeouts, crashes) are recorded, not retried silently.

## What the report contains

| Field | |
|---|---|
| Benchmark, version and split | For example "SWE-bench Verified, as of <date>, all 500 tasks" |
| Status | **Self-reported** or **Independently verified** (by whom) |
| AlbertCode version | |
| Model, provider and settings | |
| Tasks attempted | Every task in the fixed list |
| Resolved / unresolved | Counted by the official harness. Errors and timeouts count as unresolved. |
| Runtime | Median and total wall-clock time |
| Cost | Model spend and tokens, where available |
| Comparison | Only like-for-like, with source and date |
| Limitations | How the run differs from the official protocol, and anything else that affects the number |
| Evidence | Per-task outcomes, plus the harness's own output files |

## What is not published

Evidence is published so that results can be checked. It does not include AlbertCode's internal
prompts, traces or implementation. Where checking a result needs something we can't publish, the
report says what is missing, and the result can only be **self-reported**.
