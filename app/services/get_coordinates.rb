class GetCoordinates < ApplicationService
  attr_reader :location_string, :api

  def initialize(location_string)
    @location_string = location_string
    @api = Faraday.new(
      url: 'https://maps.googleapis.com/maps/api/geocode/json',
      params: { address: location_string, key: Rails.application.credentials.dig(:google_maps_api_key) },
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  def call
    response = @api.get
    coordinates = JSON.parse(response.body, symbolize_names: true)
    coordinates[:results].first[:geometry][:location]
  rescue
    nil
  end
end
