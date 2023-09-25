require "rails_helper"

RSpec.describe Weather do
  describe 'attributes' do
    let(:current_weather) { { temperature: 72.4, condition_text: 'Sunny' } }
    let(:daily_weather) { [{ date: '2023-09-23', max_temp: 76.6, min_temp: 48.7 }] }
    let(:hourly_weather) { [{ time: '13:00', temp_f: 71.6 }] }

    subject(:weather) { Weather.new(current_weather, daily_weather, hourly_weather) }

    it 'has correct attributes' do
      expect(weather.id).to eq('null')
      expect(weather.type).to eq('forecast')
      expect(weather.current_weather).to eq(current_weather)
      expect(weather.daily_weather).to eq(daily_weather)
      expect(weather.hourly_weather).to eq(hourly_weather)
    end
  end
end