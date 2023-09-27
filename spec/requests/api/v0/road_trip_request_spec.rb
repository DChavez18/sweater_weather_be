require "rails_helper"

RSpec.describe "Road Trip" do
  describe "happy path" do
    it "returns data for road trip" do
      VCR.use_cassette('road_trip_happy_path') do
        user = User.create!(email: "test@test.com", password: "test12", password_confirmation: "test12", api_key: "ghp1234512345ghy")
        
        post "/api/v0/road_trip", params: {origin: "Denver, Colorado", destination: "Pueblo, Colorado", api_key: user.api_key}
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip).to be_a(Hash)
        expect(road_trip).to have_key(:data)
        expect(road_trip[:data]).to be_a(Hash)
        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data][:id]).to eq("null")
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data][:type]).to eq("road_trip")
        expect(road_trip[:data]).to have_key(:attributes)
        expect(road_trip[:data][:attributes]).to be_a(Hash)
        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:formatted_travel_time)
        expect(road_trip[:data][:attributes][:formatted_travel_time]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        # expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        # expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)
        # expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
        # expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      end
    end
    
    it "returns impossible route if you can't travel there by way of road" do
      VCR.use_cassette('impossible_route') do
        user = User.create!(email: "test@test.com", password: "test12", password_confirmation: "test12", api_key: "ghp1234512345ghy")
        
        post "/api/v0/road_trip", params: {origin: "Denver,CO", destination: "London,UK", api_key: user.api_key}
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip).to be_a(Hash)
        expect(road_trip).to have_key(:data)
        expect(road_trip[:data]).to be_a(Hash)
        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data][:id]).to eq("null")
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data][:type]).to eq("road_trip")
        expect(road_trip[:data]).to have_key(:attributes)
        expect(road_trip[:data][:attributes]).to be_a(Hash)
        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:formatted_travel_time)
        expect(road_trip[:data][:attributes][:formatted_travel_time]).to be_a(String)
        expect(road_trip[:data][:attributes][:formatted_travel_time]).to eq("impossible route")
      end
    end
    
    it "returns data for road trip with different origin and destination" do
      VCR.use_cassette('road_trip_ny_to_la') do
        user = User.create!(email: "test@test.com", password: "test12", password_confirmation: "test12", api_key: "ghp1234512345ghy")
        
        post "/api/v0/road_trip", params: {origin: "New York, NY", destination: "Los Angeles, CA", api_key: user.api_key}, as: :json
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        road_trip = JSON.parse(response.body, symbolize_names: true)
        
        expect(road_trip).to be_a(Hash)
        expect(road_trip).to have_key(:data)
        expect(road_trip[:data]).to be_a(Hash)
        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data][:id]).to eq("null")
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data][:type]).to eq("road_trip")
        expect(road_trip[:data]).to have_key(:attributes)
        expect(road_trip[:data][:attributes]).to be_a(Hash)
        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:formatted_travel_time)
        expect(road_trip[:data][:attributes][:formatted_travel_time]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      end
    end
    
    it "can return data for a LOOOONG road trip" do
      VCR.use_cassette('road_trip_long') do
        user = User.create!(email: "test@test.com", password: "test12", password_confirmation: "test12", api_key: "ghp1234512345ghy")
        
        post "/api/v0/road_trip", params: {origin: "New York, NY", destination: "Panama City, Panama", api_key: user.api_key}, as: :json
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        road_trip = JSON.parse(response.body, symbolize_names: true)
        
        expect(road_trip).to be_a(Hash)
        expect(road_trip).to have_key(:data)
        expect(road_trip[:data]).to be_a(Hash)
        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data][:id]).to eq("null")
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data][:type]).to eq("road_trip")
        expect(road_trip[:data]).to have_key(:attributes)
        expect(road_trip[:data][:attributes]).to be_a(Hash)
        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:formatted_travel_time)
        expect(road_trip[:data][:attributes][:formatted_travel_time]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      end
    end
  end
end