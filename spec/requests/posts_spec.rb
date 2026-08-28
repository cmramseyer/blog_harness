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
end
