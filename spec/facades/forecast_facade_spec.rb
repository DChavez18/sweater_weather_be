require "rails_helper"

RSpec.describe "Forecast Facade" do
  describe "#get_weather_data" do
    it "returns current weather data for a city" do
      VCR.use_cassette('forecast_facade') do
        forecast_facade = ForecastFacade.new

        location = "denver,co"
        weather_data = forecast_facade.get_weather_data(location)

        expect(weather_data.current_weather).to be_a(Hash)
        expect(weather_data.current_weather[:last_updated]).to be_a(String)
        expect(weather_data.current_weather[:temp_f]).to be_a(Float)
        expect(weather_data.current_weather[:feelslike_f]).to be_a(Float)
        expect(weather_data.current_weather[:humidity]).to be_an(Integer)
        expect(weather_data.current_weather[:visibility_miles]).to be_a(Float)
        expect(weather_data.current_weather[:condition_text]).to be_a(String)
        expect(weather_data.current_weather[:icon]).to be_a(String)
        expect(weather_data.current_weather).to_not have_key(:wind_mph)
        expect(weather_data.current_weather).to_not have_key(:pressure_in)
      end
    end

    it "returns daily weather data for a city" do
      VCR.use_cassette('forecast_facade') do
        forecast_facade = ForecastFacade.new

        location = "denver,co"
        weather_data = forecast_facade.get_weather_data(location)

        expect(weather_data.daily_weather).to be_an(Array)
        expect(weather_data.daily_weather.count).to eq(1)
        expect(weather_data.daily_weather.first).to be_a(Hash)
        expect(weather_data.daily_weather.first[:date]).to be_a(String)
        expect(weather_data.daily_weather.first[:max_temp]).to be_a(Float)
        expect(weather_data.daily_weather.first[:min_temp]).to be_a(Float)
        expect(weather_data.daily_weather.first[:conditions]).to be_a(String)
        expect(weather_data.daily_weather.first[:icon]).to be_a(String)
        expect(weather_data.daily_weather.first[:sunrise]).to be_a(String)
        expect(weather_data.daily_weather.first[:sunset]).to be_a(String)
        expect(weather_data.daily_weather.first).to_not have_key(:maxwind_mph)
        expect(weather_data.daily_weather.first).to_not have_key(:avewind_mph)
      end
    end

    it "returns hourly weather data for a city" do
      VCR.use_cassette('forecast_facade') do
        forecast_facade = ForecastFacade.new

        location = "denver,co"
        weather_data = forecast_facade.get_weather_data(location)

        expect(weather_data.hourly_weather).to be_an(Array)
        expect(weather_data.hourly_weather.count).to eq(24)
        expect(weather_data.hourly_weather.first).to be_a(Hash)
        expect(weather_data.hourly_weather.first[:time]).to be_a(String)
        expect(weather_data.hourly_weather.first[:temp_f]).to be_a(Float)
        expect(weather_data.hourly_weather.first[:conditions]).to be_a(String)
        expect(weather_data.hourly_weather.first[:icon]).to be_a(String)
        expect(weather_data.hourly_weather.first).to_not have_key(:wind_mph)
        expect(weather_data.hourly_weather.first).to_not have_key(:pressure_in)
      end
    end
  end
end