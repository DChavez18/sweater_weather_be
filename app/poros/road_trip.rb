class RoadTrip
  attr_reader :id,
              :type,
              :start_city, 
              :end_city, 
              :formatted_travel_time, 
              :weather_at_eta

  def initialize(start_city, end_city, formatted_travel_time, weather_at_eta)
    @id = "null"
    @type = "roadtrip"
    @start_city = start_city
    @end_city = end_city
    @formatted_travel_time = formatted_travel_time
    @weather_at_eta = weather_at_eta
  end
end