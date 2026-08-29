---
description: Implement next product requirement
agent: build
---

Execute one harness iteration.

Read:

- AGENTS.md
- docs/DESIGN.md
- docs/REQUIREMENTS.md

Find the first requirement with:

Status: todo

If none exists:

Change `Project status:` to `complete` and stop.

Otherwise: Planning phase, then Building phase.

## Planning phase
After selecting the next requirement:
1. Read:
   - AGENTS.md
   - docs/DESIGN.md
   - docs/REQUIREMENTS.md
   - relevant existing application code
2. Before modifying application code, create:
   `.harness/plans/PLAN-<REQ-ID>.md`
   Example:
   `.harness/plans/PLAN-REQ-001.md`
3. The plan must contain:
   # REQ-001 — <title>
   ## Goal
   Short description of what must be achieved.
   ## Relevant existing code
   Files/components expected to be involved.
   ## Implementation plan
   1. ...
   2. ...
   3. ...
   ## Tests
   Tests that will be added or modified.
   ## Risks / considerations
   Relevant migrations, compatibility issues, edge cases, etc.
4. Keep the plan concise. Do not implement anything until the plan file exists.
5. After writing the plan, continue immediately with the normal implementation workflow.
6. Use the plan as guidance, but update it if implementation reveals that the original assumptions were incorrect.


## Building phase

1. Set the requirement to `in_progress`.
2. Understand its acceptance criteria.
3. Inspect the relevant existing Rails code.
4. Implement the requirement.
5. Add or modify tests covering its acceptance criteria.
6. Run `bin/verify`.
7. Fix failures until verification succeeds.
8. Invoke the `reviewer` subagent using the subagent/task tool.
9. Ask the reviewer to independently review:
   - the current requirement
   - all acceptance criteria
   - the implementation
   - the tests
   - the current git diff
10. Do not commit or push anything before the reviewer finishes.
11. Inspect the reviewer's final verdict.

### If the reviewer returns:

`VERDICT: APPROVE`

Continue with the normal commit and push workflow.

### If the reviewer returns:

`VERDICT: REJECT`

- Do not commit.
- Do not push.
- Save the complete reviewer output to:

`.harness/reviews/REVIEW-<REQ-ID>.md`

- Mark the requirement as `blocked`.
- Add `Blocked reason: Review failed; see .harness/reviews/REVIEW-<REQ-ID>.md for details.` underneath the status.
- Stop processing this requirement.
- Do not continue with another requirement.

12. Create a concise descriptive commit message based on the requirement. Prefer this format: `REQ-XXX: <short-description>`.
13. If everything succeeds, change the requirement status to `done`.
14. Ensure all changes are staged before committing.
15. Run `bin/commit-and-push "<commit-message>"`.
16. Get the current OpenCode session ID using `session-info`.
17. Export the session:

   `opencode export <session-id> > .harness/runs/<REQ-ID>-session-<session-id>.json`
<!-- 9. Run `bin/smoke-staging`. -->

Ignore commented lines.

If implementation, verification or deployment cannot be completed:

Set the requirement to `blocked`.

Add a short `Blocked reason:` underneath it.

Do not work on another requirement.

<!-- Never mark a requirement `done` unless verification and deployment succeeded. -->
