class RoadTripSerializer
  include JSONAPI::Serializer
  attributes :id, :start_city, :end_city, :formatted_travel_time, :weather_at_eta

  set_id :null_id do
    "null"
  end
end