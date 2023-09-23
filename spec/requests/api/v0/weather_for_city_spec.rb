require "rails_helper"

RSpec.describe "Forecast API", type: :request do
  describe "GET /api/v0/forecast" do
    it "returns a forecast for a city" do
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      get "/api/v0/forecast?city=denver,co", headers: headers
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns an error when city is missing' do
      get '/api/v0/forecast'
      expect(response).to have_http_status(400) 
    end

    it 'returns an error when city is invalid' do
      get '/api/v0/forecast?city=InvalidCityName' 
      expect(response).to have_http_status(400)
    end
  end
end
