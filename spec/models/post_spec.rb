require "rails_helper"

RSpec.describe Post do
  let(:user) { User.create!(email: "writer@example.com", password: "password") }

  it "belongs to a user" do
    post = user.posts.create!(title: "My post", content: "Post content")

    expect(post.user).to eq(user)
  end

  it "requires a title and content" do
    post = user.posts.build

    expect(post).not_to be_valid
    expect(post.errors.of_kind?(:title, :blank)).to be(true)
    expect(post.errors.of_kind?(:content, :blank)).to be(true)
  end
end
