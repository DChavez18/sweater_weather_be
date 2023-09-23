class Api::V0::ForecastController < ApplicationController
  def index
    if params[:city].nil?
      render json: { error: "Please provide a city name" }, status: 400
    else
      forecast = ForecastFacade.new.get_weather_data(params[:city])
      render json: ForecastSerializer.new(forecast)
    end
  end 
end