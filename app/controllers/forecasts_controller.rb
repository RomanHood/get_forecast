class ForecastsController < ApplicationController
  def get
    coordinates = GetCoordinates.call(params[:address])
    @forecast = GetForecast.call(coordinates[:lat], coordinates[:lng])
  end
end
