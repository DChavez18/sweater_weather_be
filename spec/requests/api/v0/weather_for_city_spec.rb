require "rails_helper"

RSpec.describe "Forecast API", type: :request do
  describe "GET /api/v0/forecast" do
    it "returns a forecast for a city" do
      get "/api/v0/forecast?city=cincinatti,oh"

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end
