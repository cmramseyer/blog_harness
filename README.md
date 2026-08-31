# Product Requirement Harness

This Rails application is developed through small, reviewable product
requirements. OpenCode selects one requirement, plans it, implements and
verifies it, obtains an independent review, and records the resulting session.

## Quick path

1. Start OpenCode from the repository root with `opencode .`.
2. Run `/next` in the OpenCode session.
3. Review the generated plan, implementation, verification result, reviewer
   verdict, commit, and exported session artifact.

`/next` is an OpenCode command defined at `.opencode/commands/next.md`. It is
not the shell command `opencode next`.

## Workflow

`/next` runs exactly one harness iteration:

1. Reads `AGENTS.md`, `docs/DESIGN.md`, and `docs/REQUIREMENTS.md`.
2. Selects the first requirement with `Status: todo`.
3. Creates `.harness/plans/PLAN-<REQ-ID>.md` before application code changes.
4. Marks the requirement `in_progress`, implements its acceptance criteria,
   and adds or updates tests.
5. Runs `bin/verify`, which runs RuboCop and RSpec.
6. Requests an independent verdict from the `reviewer` subagent.
7. On approval, commits and pushes, then exports the OpenCode session to
   `.harness/runs/`.
8. Marks the requirement `done` only after the complete workflow succeeds.

If any stage fails, the requirement becomes `blocked` with a short reason.
Rejected reviews are saved in `.harness/reviews/`, and the command stops rather
than moving to another requirement. If there are no `todo` requirements, the
project status becomes `complete`.

## Sources of truth

| File | Purpose |
| --- | --- |
| `AGENTS.md` | Non-negotiable repository workflow and Rails conventions for agents. |
| `docs/DESIGN.md` | Architectural, database, background-job, and testing constraints. |
| `docs/REQUIREMENTS.md` | Ordered product requirements, acceptance criteria, and lifecycle state. |
| `.opencode/commands/next.md` | Detailed orchestration for one `/next` iteration. |
| `.opencode/agents/reviewer.md` | Independent review criteria and required `APPROVE` or `REJECT` verdict. |

## Requirement states

| Status | Meaning |
| --- | --- |
| `todo` | Eligible to be selected by the next iteration. |
| `in_progress` | Currently being planned, built, verified, or reviewed. |
| `done` | Verified, independently approved, committed, pushed, and recorded. |
| `blocked` | The iteration could not proceed; the requirement records why. |

## Harness artifacts

| Path | Contents |
| --- | --- |
| `.harness/plans/` | Concise plan for each selected requirement. |
| `.harness/reviews/` | Full reviewer output for rejected requirements. |
| `.harness/runs/` | Exported OpenCode session after a successful iteration. |

## Boundaries

The harness handles local verification, independent review, commit, push, and
session export. This repository does not provide staging deployment or smoke
test commands. Production deployments require explicit human approval.

## Local verification

Run the full local gate manually when needed:

```bash
bin/verify
```
