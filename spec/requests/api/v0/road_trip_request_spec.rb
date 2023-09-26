require "rails_helper"

RSpec.describe "Road Trip" do
  describe "happy path" do
    it "returns data for road trip" do
      user = User.create!(email: "test@test.com, password: test, password_confirmation: test", api_key: "ghp1234512345ghy")

      post "/api/v0/road_trip", params: {origin: "Denver,CO", destination: "Pueblo,CO", api_key: user.api_key}

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end