require 'rails_helper'

RSpec.describe "forecasts/new", type: :view do
  it "renders new url form" do
    render

    assert_select "form[action=?][method=?]", get_forecast_path, "get" do
      assert_select "input[name=?]", "address"
      assert_select "input[type=?]", "submit"
    end
  end
end
