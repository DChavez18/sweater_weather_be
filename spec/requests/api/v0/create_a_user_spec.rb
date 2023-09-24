require "rails_helper"

RSpec.describe "User Registration" do
  describe "happy path" do
    it "creates a user and returns an api key" do
      post "/api/v0/users", params: {email: "test_email@test.com", password: "password", password_confirmation: "password"}, as: :json
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end
end