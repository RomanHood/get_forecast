class ForecastsController < ApplicationController
  def get
    coordinates = GetCoordinatesService.new(params[:address]).call
    @forecast = GetForecastService.new(coordinates[:lat], coordinates[:lng]).call
  end

  def new
  end

  private

  def forecast_params
    params[:address]
  end
end
