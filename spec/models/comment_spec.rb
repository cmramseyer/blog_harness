require "rails_helper"

RSpec.describe Comment do
  let(:user) { User.create!(email: "writer@example.com", password: "password") }
  let(:post) { user.posts.create!(title: "My post", content: "Post content") }

  it "belongs to a post and user" do
    comment = described_class.create!(post:, user:, content: "A comment")

    expect(comment).to have_attributes(post:, user:)
  end

  it "requires content" do
    comment = described_class.new(post:, user:)

    expect(comment).not_to be_valid
    expect(comment.errors.of_kind?(:content, :blank)).to be(true)
  end
end
