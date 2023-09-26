class Api::V0::RoadTripController < ApplicationController
  def create
    user = authenticate_user(params[:api_key])
    if user
      road_trip = RoadTripFacade.new.find_travel_time(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    else
      render_unauthorized
    end
  rescue RoadTripErrors::ValidationError => e
    render_validation_error(e.message)
  end

  private

  def api_key_valid?(api_key)
    api_key.present? && api_key.length >= 10
  end

  def authenticate_user(api_key)
    user = User.find_by(api_key: api_key)
    user if user.present?
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: 401
  end

  def render_validation_error(message)
    render json: { error: message }, status: 400
  end
end