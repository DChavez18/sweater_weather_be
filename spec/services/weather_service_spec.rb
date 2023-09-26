require "rails_helper"

RSpec.describe "Weather Service" do
  describe "instance methods" do
    it "returns weather current weather data, based on location" do
      VCR.use_cassette('weather_service') do
        weather = WeatherService.new
        weather_data = weather.get_weather_data(39.738453, -104.984853)

        expect(weather_data).to be_a(Hash)
        expect(weather_data).to have_key(:current)
        expect(weather_data[:current]).to be_a(Hash)
        expect(weather_data[:current]).to have_key(:last_updated)
        expect(weather_data[:current][:last_updated]).to be_a(String)
        expect(weather_data[:current]).to have_key(:temp_f)
        expect(weather_data[:current][:temp_f]).to be_a(Float)
        expect(weather_data[:current]).to have_key(:feelslike_f)
        expect(weather_data[:current][:feelslike_f]).to be_a(Float)
        expect(weather_data[:current]).to have_key(:humidity)
        expect(weather_data[:current][:humidity]).to be_an(Integer)
        expect(weather_data[:current]).to have_key(:vis_miles)
        expect(weather_data[:current][:vis_miles]).to be_a(Float)
        expect(weather_data[:current]).to have_key(:condition)
        expect(weather_data[:current][:condition]).to be_a(Hash)
        expect(weather_data[:current][:condition]).to have_key(:text)
        expect(weather_data[:current][:condition][:text]).to be_a(String)
        expect(weather_data[:current][:condition]).to have_key(:icon)
        expect(weather_data[:current][:condition][:icon]).to be_a(String)
      end
    end

    it "returns weather daily weather data, based on location" do
      VCR.use_cassette('weather_service') do
        weather = WeatherService.new
        weather_data = weather.get_weather_data(39.738453, -104.984853)

        expect(weather_data).to be_a(Hash)
        expect(weather_data).to have_key(:forecast)
        expect(weather_data[:forecast]).to be_a(Hash)
        expect(weather_data[:forecast]).to have_key(:forecastday)
        expect(weather_data[:forecast][:forecastday]).to be_an(Array)
        expect(weather_data[:forecast][:forecastday].count).to eq(1)
      end
    end

    it "returns weather hourly weather data, based on location" do
      VCR.use_cassette('weather_service') do
        weather = WeatherService.new
        weather_data = weather.get_weather_data(39.738453, -104.984853)

        expect(weather_data).to be_a(Hash)
        expect(weather_data).to have_key(:forecast)
        expect(weather_data[:forecast]).to be_a(Hash)
        expect(weather_data[:forecast]).to have_key(:forecastday)
        expect(weather_data[:forecast][:forecastday]).to be_an(Array)
        expect(weather_data[:forecast][:forecastday].count).to eq(1)
        expect(weather_data[:forecast][:forecastday][0]).to have_key(:hour)
        expect(weather_data[:forecast][:forecastday][0][:hour]).to be_an(Array)
        expect(weather_data[:forecast][:forecastday][0][:hour].count).to eq(24)
      end
    end
  end
end