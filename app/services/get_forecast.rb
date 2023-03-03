class GetForecast < ApplicationService
  attr_reader :api

  def initialize lat, lon
    @lat = lat
    @lon = lon
    @api = Faraday.new(
      url: 'https://api.open-meteo.com/v1/',
      params: build_request_params,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
    
  def self.call lat, lon
    new(lat, lon).call
  end

  def call
    response = @api.get('gfs', latitude: @lat, longitude: @lon)
    @forecast = JSON.parse(response.body).with_indifferent_access
    build_forecast
  end

  private

  def build_request_params
    {
      temperature_unit: 'fahrenheit',
      current_weather: true,
      daily: ["temperature_2m_max", "temperature_2m_min"],
      timezone: "auto"
    }
  end

  def build_forecast
    {
      current_temperature: @forecast[:current_weather][:temperature],
      forecast: build_daily_forecast
    }
  end

  def build_daily_forecast
    time_arr = @forecast[:daily][:time]
    max_arr = @forecast[:daily][:temperature_2m_max]
    min_arr = @forecast[:daily][:temperature_2m_min]
    time_arr.zip(max_arr, min_arr).reduce({}) do |memo, value|
      memo[value[0]] = { max: value[1], min: value[2] }
      memo
    end
  end
end
