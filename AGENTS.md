# Project

Ruby on Rails application.

## Workflow

Use the `/next` command to execute one product-requirement iteration. Its
implementation lives in `.opencode/commands/next.md`.

For every iteration:

1. Read this file, `docs/DESIGN.md`, and `docs/REQUIREMENTS.md`.
2. Work only on the first requirement whose status is `todo`.
3. Before changing application code, create a concise plan at
   `.harness/plans/PLAN-<REQ-ID>.md`.
4. Mark the selected requirement as `in_progress` and implement only its
   acceptance criteria.
5. Add or update automated tests and run `bin/verify`.
6. Request an independent review from the `reviewer` subagent before
   committing or pushing.
7. Commit and push only when the reviewer returns `VERDICT: APPROVE`.
8. Export the OpenCode session to `.harness/runs/` after a successful push.
9. Mark the requirement as `done` only after the complete workflow succeeds.

If planning, implementation, verification, review, commit, or push fails,
mark the requirement as `blocked`, add a short `Blocked reason:`, and stop.
When review rejects the work, save the complete review at
`.harness/reviews/REVIEW-<REQ-ID>.md` before blocking the requirement.

Do not work on more than one requirement in an iteration. If no requirement
has status `todo`, set `Project status:` to `complete` and stop.

## Rails

Follow existing Rails conventions.

- Prefer RESTful controllers and ActiveRecord.
- Reuse existing architecture before adding abstractions.
- Add database constraints when appropriate.
- Test observable behavior.
- Keep migrations backward compatible.
- Do not combine destructive migrations with code that depends on them.

## Deployment

This repository has no deployment or smoke-test commands. The harness workflow
ends after verification, independent review, commit, push, and session export.
Never add or perform a production deployment without explicit human approval.

<!-- CODEGRAPH_START -->
## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool** (when available): `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow. Name a file or symbol in the query to read its current line-numbered source. If it's listed but deferred, load it by name via tool search.
- **Shell** (always works): `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is the user's decision.
<!-- CODEGRAPH_END -->
