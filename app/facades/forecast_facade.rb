class ForecastFacade
  def get_weather_data(location)
    json = MapquestService.new.get_mapquest_data(location)
    data = json[:results][0][:locations][0][:latLng]
    city_coords = Mapquest.new(data)
    weather_data = WeatherService.new.get_weather_data(city_coords.lat, city_coords.lon)

    current_weather = format_current_weather(weather_data[:current])
    daily_weather = format_daily_weather(weather_data[:forecast][:forecastday])
    hourly_weather = format_hourly_weather(weather_data[:forecast][:forecastday][0][:hour])

    Weather.new(current_weather, daily_weather, hourly_weather)
  end

  private

  def format_current_weather(current_data)
    {
      last_updated: current_data[:last_updated],
      temp_f: current_data[:temp_f],
      condition_text: current_data[:condition][:text],
      icon: current_data[:condition][:icon],
      humidity: current_data[:humidity],
      feelslike_f: current_data[:feelslike_f],
      visibility_miles: current_data[:vis_miles],
      uvi: current_data[:uv]
    }
  end

  def format_daily_weather(daily_data)
    daily_data.map do |day|
      {
        date: day[:date],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        conditions: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset]
      }
    end
  end

  def format_hourly_weather(hourly_data)
    hourly_data.map do |hour|
      {
        time: DateTime.parse(hour[:time]).strftime("%H:%M"),
        temp_f: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end

# class ForecastFacade
#   def get_weather_data(location)
#     json = MapquestService.new.get_mapquest_data(location)
#     data = json[:results][0][:locations][0][:latLng]
#     city_coords = Mapquest.new(data)
#     weather_data = WeatherService.new.get_weather_data(city_coords.lat, city_coords.lon)
#     current_weather = 
#     {
#       last_updated: weather_data[:current][:last_updated],
#       temp_f: weather_data[:current][:temp_f],
#       condition_text: weather_data[:current][:condition][:text],
#       icon: weather_data[:current][:condition][:icon],
#       humidity: weather_data[:current][:humidity],
#       feelslike_f: weather_data[:current][:feelslike_f],
#       visibility_miles: weather_data[:current][:vis_miles],
#       uvi: weather_data[:current][:uv]
#     }

#     daily_weather = weather_data[:forecast][:forecastday].map do |day|
#       {
#       date: day[:date],
#       max_temp: day[:day][:maxtemp_f],
#       min_temp: day[:day][:mintemp_f],
#       conditions: day[:day][:condition][:text],
#       icon: day[:day][:condition][:icon],
#       sunrise: day[:astro][:sunrise],
#       sunset: day[:astro][:sunset]
#     }
#     end

#     hourly_weather = weather_data[:forecast][:forecastday][0][:hour].map do |hour|
#       {
#       time: DateTime.parse(hour[:time]).strftime("%H:%M"),
#       temp_f: hour[:temp_f],
#       conditions: hour[:condition][:text],
#       icon: hour[:condition][:icon]
#     }
#     end

#     Weather.new(current_weather, daily_weather, hourly_weather)
#   end
# end