# REQ-009 — Root a Posts

## Goal

Render the existing posts listing at the root path.

## Relevant existing code

- `config/routes.rb` defines the current root route.
- `PostsController#index` loads the posts listing.
- `app/views/posts/index.html.erb` renders the listing.
- `spec/requests/posts_spec.rb` covers post HTTP behavior.

## Implementation plan

1. Route `/` to `PostsController#index`.
2. Add a request spec confirming the root renders a post listing.
3. Run the project verification suite and staging checks.

## Tests

- Add a request spec for `GET /` that asserts the posts index content is rendered.

## Risks / considerations

- The change replaces the existing `HomeController` root endpoint only; the posts index remains publicly accessible as it is today.
