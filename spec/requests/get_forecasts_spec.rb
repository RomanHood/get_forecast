require 'rails_helper'

RSpec.describe "GetForecasts", type: :request do
  it "fetches forecasts" do
    allow(ForecastService).to receive(:call).and_return("70 degrees")
    expect(ForecastService).to receive(:call).with("London")

    visit root_path
    fill_in "city", with: "London"
    click_button "Get Forecast"
  end
end
