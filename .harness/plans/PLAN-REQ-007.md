# REQ-007 - Nombre de usuario en comentarios

## Goal
Show each comment author's email above its content on a post detail page.

## Relevant existing code
- `app/views/posts/show.html.erb` renders post comments.
- `spec/requests/posts_spec.rb` covers the post detail page and comments.

## Implementation plan
1. Add the required author label to each rendered comment.
2. Extend the post detail request spec to assert the label and email.

## Tests
- Request spec for displaying a comment with its author's email label.

## Risks / considerations
- Preserve the existing comment form and markup style; no schema or controller changes are needed.
