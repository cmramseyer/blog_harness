# REQ-008 — Fecha y hora de comentarios

## Goal

Show each comment's creation date and time beside its author in the required format.

## Relevant existing code

- `app/views/posts/show.html.erb` renders comment author and content.
- `spec/requests/posts_spec.rb` covers the post detail page.

## Implementation plan

1. Format `comment.created_at` in the comment author line on the post detail page.
2. Add request coverage for the required date, time, author, and text output.

## Tests

- Extend the post detail request spec to assert `dd/mm/yy HH:MM - User <email> comentó`.

## Risks / considerations

- Use the existing timestamp with no schema or timezone behavior changes.
