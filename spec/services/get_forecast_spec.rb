require 'rails_helper'

RSpec.describe GetForecast do
  subject { described_class }

  describe '.call' do
    it 'returns a forecast' do
      VCR.use_cassette('forecast') do
        response = subject.call(37.8267, -122.4233)

        expect(response).to be_a(Hash)
        expect(response).to have_key(:current_temperature)
        expect(response).to have_key(:forecast)
        expect(response[:forecast]).to be_a(Hash)
        expect(response[:forecast].size).to eq 7
      end
    end
  end
end
