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

Otherwise:

1. Set the requirement to `in_progress`.
2. Understand its acceptance criteria.
3. Inspect the relevant existing Rails code.
4. Implement the requirement.
5. Add or modify tests covering its acceptance criteria.
6. Run `bin/verify`.
7. Fix failures until verification succeeds.
8. Create a concise descriptive commit message based on the requirement. Prefer this format: `REQ-XXX: <short-description>`.
9. Run `bin/commit-and-push "<commit-message>"`.
<!-- 9. Run `bin/smoke-staging`. -->
10. If everything succeeds, change the requirement status to `done`.

Ignore commented lines.

If implementation, verification or deployment cannot be completed:

Set the requirement to `blocked`.

Add a short `Blocked reason:` underneath it.

Do not work on another requirement.

<!-- Never mark a requirement `done` unless verification and deployment succeeded. -->
