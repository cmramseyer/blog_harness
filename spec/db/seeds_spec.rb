require "rails_helper"

RSpec.describe "Database seeds" do
  it "creates the configured users with their passwords" do
    load Rails.root.join("db/seeds.rb").to_s
    load Rails.root.join("db/seeds.rb").to_s

    expect(User.where(email: %w[admin@blog.com user@blog.com]).count).to eq(2)
    expect(User.find_by!(email: "admin@blog.com")).to be_valid_password("blog1234")
    expect(User.find_by!(email: "user@blog.com")).to be_valid_password("blog1234")
  end
end
