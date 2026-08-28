# Design

## Architecture

- This is a Rails monolith.
- Keep controllers focused on HTTP requests.
- Put business logic in models or service objects when needed.
- Do not add microservices or infrastructure without a product requirement.

## Database

- SQLite is the source of truth.
- Use foreign keys and database constraints when appropriate.
- Avoid N+1 queries.
- Use expand/migrate/contract for destructive schema changes.

## Background jobs

- Use ActiveJob for asynchronous work.
- Jobs should be idempotent when possible.

## Testing

- Use RSpec.
- Cover each requirement's acceptance criteria with automated tests.
