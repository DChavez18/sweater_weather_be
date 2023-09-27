require "rails_helper"

RSpec.describe 'RoadTripFacade' do
  describe '#find_travel_time' do
    it 'returns a road trip object with travel time and weather data' do
      VCR.use_cassette('road_trip_facade') do
        road_trip_facade = RoadTripFacade.new
        origin = 'Denver, Colorado'
        destination = 'Pueblo, Colorado'

        road_trip = road_trip_facade.find_travel_time(origin, destination)

        expect(road_trip).to be_a(RoadTrip)

        expect(road_trip.start_city).to eq(origin)
        expect(road_trip.end_city).to eq(destination)
        expect(road_trip.type).to eq('roadtrip')

        expect(road_trip.formatted_travel_time).to be_a(String)

        weather_at_eta = road_trip.weather_at_eta
        expect(weather_at_eta).to be_a(Hash)
        # expect(weather_at_eta[:datetime]).to be_a(String)
        # expect(weather_at_eta[:temperature]).to be_a(Float)
        # expect(weather_at_eta[:conditions]).to be_a(String)

        expect(road_trip.id).to eq('null')
      end
    end
  end
end