# REQ-6 — Comentar posts

## Goal
Allow authenticated users to create required-content comments on a post and display them on its detail page.

## Relevant existing code
- `Post`, `User`, and their associations
- `PostsController` and `posts/show.html.erb`
- Post request/model specs and database migrations

## Implementation plan
1. Add a `Comment` model and migration with required post, user, and content.
2. Add nested comment creation under posts, authenticated via Devise.
3. Render existing comments and an authenticated textarea form on the post page.
4. Cover model associations/validation and request creation/display behavior.

## Tests
- Comment associations and required content validation.
- Authenticated comment creation and redirect.
- Comments and form shown on a post detail page.

## Risks / considerations
- Add foreign keys and non-null constraints for referential integrity.
- Keep the implementation server-rendered without AJAX or Stimulus.
