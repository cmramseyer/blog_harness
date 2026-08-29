require "rails_helper"

RSpec.describe "Posts" do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(email: "writer@example.com", password: "password") }

  it "allows an authenticated user to create a post" do
    sign_in user

    expect do
      post posts_path, params: { post: { title: "My post", content: "Post content" } }
    end.to change(user.posts, :count).by(1)

    expect(response).to redirect_to(posts_path)
  end

  it "requires authentication to create a post" do
    post posts_path, params: { post: { title: "My post", content: "Post content" } }

    expect(response).to redirect_to(new_user_session_path)
  end

  it "lists posts with links to their detail pages" do
    post = user.posts.create!(title: "My post", content: "Post content")

    get posts_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(post.title, post.content, post_path(post))
  end

  it "shows a post detail page" do
    post = user.posts.create!(title: "My post", content: "Post content")

    get post_path(post)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(post.title, post.content)
  end

  it "allows the author to edit a post" do
    post = user.posts.create!(title: "My post", content: "Post content")
    sign_in user

    get edit_post_path(post)
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("post[title]", "post[content]")

    patch post_path(post), params: { post: { title: "Updated post", content: "Updated content" } }

    expect(response).to redirect_to(post_path(post))
    expect(post.reload).to have_attributes(title: "Updated post", content: "Updated content")
  end

  it "prevents another user from editing a post" do
    post = user.posts.create!(title: "My post", content: "Post content")
    other_user = User.create!(email: "other@example.com", password: "password")
    sign_in other_user

    get edit_post_path(post)
    expect(response).to redirect_to(post_path(post))

    patch post_path(post), params: { post: { title: "Updated post", content: "Updated content" } }

    expect(response).to redirect_to(post_path(post))
    expect(post.reload).to have_attributes(title: "My post", content: "Post content")
  end

  it "allows an authenticated user to comment on a post" do
    post = user.posts.create!(title: "My post", content: "Post content")
    sign_in user

    expect do
      post post_comments_path(post), params: { comment: { content: "A comment" } }
    end.to change(post.comments, :count).by(1)

    expect(response).to redirect_to(post_path(post))
    expect(post.comments.last).to have_attributes(content: "A comment", user:)
  end

  it "shows comments with their authors and a comment form on a post detail page" do
    post = user.posts.create!(title: "My post", content: "Post content")
    comment = post.comments.create!(user:, content: "A comment", created_at: Time.zone.local(2026, 8, 28, 14, 30))
    sign_in user

    get post_path(post)

    expect(response.body).to include(
      "#{comment.created_at.strftime('%d/%m/%y %H:%M')} - User #{user.email} comentó",
      "A comment",
      "comment[content]"
    )
  end
end
