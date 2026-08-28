require "rails_helper"

RSpec.describe "Authentication" do
  let(:email) { "reader@example.com" }
  let(:password) { "password" }

  it "registers a user with an email and password" do
    expect do
      post user_registration_path, params: { user: { email:, password:, password_confirmation: password } }
    end.to change(User, :count).by(1)

    expect(response).to redirect_to(root_path)
    expect(User.last).to have_attributes(email:)
  end

  it "signs in a registered user" do
    User.create!(email:, password:)

    post user_session_path, params: { user: { email:, password: } }

    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response.body).to include("Signed in as #{email}")
  end

  it "signs out a signed-in user" do
    User.create!(email:, password:)
    post user_session_path, params: { user: { email:, password: } }

    delete destroy_user_session_path

    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response.body).to include("Sign in")
  end
end
