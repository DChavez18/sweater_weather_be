class RoadTripFacade
  def find_travel_time(origin, destination)
    validate_input(origin, destination)
    json = MapquestService.new.get_mapquest_data(destination)
    data = json[:results][0][:locations][0][:latLng]
    final_destination = Mapquest.new(data)
    destination_weather = WeatherService.new.get_weather_data(final_destination.lat, final_destination.lon)
    travel_data = MapquestService.new.get_directions_data(origin, destination)
    travel_time = travel_data[:route][:realTime]

    if travel_time.nil?
      return RoadTrip.new(origin, destination, "impossible route", {})
    else
      formatted_travel_time = travel_data[:route][:formattedTime]
      arrival_time = Time.now + travel_time

      destination_weather[:forecast][:forecastday].each do |day|
        next unless arrival_time.to_s.include?(day[:date])
        
        day[:hour].each do |hour|
          hour_time = Time.parse(hour[:time])
          if arrival_time.between?(hour_time, hour_time + 1.hour)
            weather_at_eta = {
              datetime: hour[:time],
              temperature: hour[:temp_f],
              conditions: hour[:condition][:text]
            }
            return RoadTrip.new(origin, destination, formatted_travel_time, weather_at_eta)
          end    
        end
      end

      return RoadTrip.new(origin, destination, "unknown travel time", {})
    end
  end

  private

  def validate_input(origin, destination)
    unless origin.present? && destination.present?
      raise RoadTripErrors::ValidationError, "Please provide both origin and destination"
    end
  end
end