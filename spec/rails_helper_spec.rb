require "rails_helper"

RSpec.describe Rails.application do
  it "boots in the test environment" do
    expect(Rails.env).to be_test
  end
end
