require 'rails_helper'

RSpec.describe "GetForecasts", type: :request do
  it "fetches forecasts" do
    allow_any_instance_of(GetCoordinatesService).to receive(:call).and_return({lat: 51.5074, lon: 0.1278})
    allow(GetForecastService).to receive(:call).and_return({
      current_temperature: "70",
      forecast: {
        "2021-05-01": {
          max: "70",
          min: "50"
        },
        "2021-05-02": {
          max: "70",
          min: "50"
        },
        "2021-05-03": {
          max: "70",
          min: "50"
        },
        "2021-05-04": {
          max: "70",
          min: "50"
        },
        "2021-05-05": {
          max: "70",
          min: "50"
        }
      }
    })

    visit root_path
    fill_in "address", with: "123 Main St, Anytown, USA"
    click_button "Get Forecast"
  end
end
