class ForecastsController < ApplicationController
  def get
    cache_key = "forecast-#{params[:address]}"
    @forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      coordinates = GetCoordinates.call(params[:address])
      @forecast = GetForecast.call(coordinates[:lat], coordinates[:lng])
    end
  end

  def new
  end
end
