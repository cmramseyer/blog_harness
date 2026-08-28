# Project

Ruby on Rails application.

## Workflow

Before implementing a product requirement:

1. Read `docs/DESIGN.md` and `docs/REQUIREMENTS.md`.
2. Work on the first requirement marked as `todo`.
3. Handle only one requirement at a time and mark it `in_progress`.
4. Make the smallest change that meets its acceptance criteria.
5. Add or update tests.
6. Run `bin/verify`.
7. Deploy to staging with `bin/deploy-staging` and run `bin/smoke-staging`.
8. Mark the requirement as `done` only after all checks pass.

If blocked, mark it as `blocked` and explain why.

## Rails

Follow existing Rails conventions.

- Prefer RESTful controllers and ActiveRecord.
- Reuse existing architecture before adding abstractions.
- Add database constraints when appropriate.
- Test observable behavior.
- Keep migrations backward compatible.
- Do not combine destructive migrations with code that depends on them.

## Deployment

Deployments are allowed only to staging.

Never deploy to production without explicit human approval.
