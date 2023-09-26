class RoadTripFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def road_trip
    RoadTrip.new(road_trip_info)
  end

  private

  def road_trip_info
    @road_trip_info ||= RoadTripService.new(@origin, @destination).road_trip_info
  end
end