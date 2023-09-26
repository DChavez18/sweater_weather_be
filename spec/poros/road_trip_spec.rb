require "rails_helper"

RSpec.describe RoadTrip do
  describe 'initialize' do
    it 'creates a RoadTrip object with the correct attributes' do
      start_city = 'Denver, Colorado'
      end_city = 'Pueblo, Colorado'
      formatted_travel_time = '01:30:00'
      weather_at_eta = {
        datetime: '2023-09-28 15:00',
        temperature: 80.5,
        conditions: 'Sunny'
      }

      road_trip = RoadTrip.new(start_city, end_city, formatted_travel_time, weather_at_eta)

      expect(road_trip.id).to eq('null')
      expect(road_trip.type).to eq('roadtrip')
      expect(road_trip.start_city).to eq(start_city)
      expect(road_trip.end_city).to eq(end_city)
      expect(road_trip.formatted_travel_time).to eq(formatted_travel_time)
      expect(road_trip.weather_at_eta).to eq(weather_at_eta)
    end
  end
end
  