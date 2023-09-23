require "rails_helper"

RSpec.describe "Forecast API", type: :request do
  describe "GET /api/v0/forecast" do
    it "returns a forecast for a city" do
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      get "/api/v0/forecast?city=denver,co", headers: headers
      
      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to be_a(Hash)
      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to be_a(Hash)
      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data][:id]).to eq("null")
      expect(forecast[:data]).to have_key(:type)
      expect(forecast[:data][:type]).to eq("forecast")
      expect(forecast[:data]).to have_key(:attributes)
      expect(forecast[:data][:attributes]).to be_a(Hash)
      expect(forecast[:data][:attributes]).to have_key(:current_weather)
      expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(forecast[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:temp_f)
      expect(forecast[:data][:attributes][:current_weather][:temp_f]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:feelslike_f)
      expect(forecast[:data][:attributes][:current_weather][:feelslike_f]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_an(Integer)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:visibility_miles)
      expect(forecast[:data][:attributes][:current_weather][:visibility_miles]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:condition_text)
      expect(forecast[:data][:attributes][:current_weather][:condition_text]).to be_a(String)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a(String)
      expect(forecast[:data][:attributes]).to_not have_key(:wind_mph)
      expect(forecast[:data][:attributes]).to_not have_key(:pressure_in)

      expect(forecast[:data][:attributes]).to have_key(:daily_weather)
      expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(forecast[:data][:attributes][:daily_weather].count).to eq(1)

      forecast[:data][:attributes][:daily_weather].each do |day|
        expect(day).to be_a(Hash)
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)
        expect(day).to have_key(:max_temp)
        expect(day[:max_temp]).to be_a(Float)
        expect(day).to have_key(:min_temp)
        expect(day[:min_temp]).to be_a(Float)
        expect(day).to have_key(:conditions)
        expect(day[:conditions]).to be_a(String)
        expect(day).to have_key(:icon)
        expect(day[:icon]).to be_a(String)
        expect(day).to have_key(:sunrise)
        expect(day[:sunrise]).to be_a(String)
        expect(day).to have_key(:sunset)
        expect(day[:sunset]).to be_a(String)
      end
    end
  end
end
