require 'rails_helper'

RSpec.shared_examples 'a valid location' do |location|
  it 'returns coordinates for a given city' do
    VCR.use_cassette(location) do
      coordinates = subject.call(location)

      expect(coordinates).to be_a(Hash)
      expect(coordinates).to have_key(:lat)
      expect(coordinates[:lat]).to be_a(Float)
      expect(coordinates).to have_key(:lng)
      expect(coordinates[:lng]).to be_a(Float)
    end
  end
end

RSpec.describe GetCoordinatesService do
  describe '.call' do
    subject { described_class }

    VCR.use_cassette('denver_co') do
      include_examples "a valid location", "denver,co"
    end
    VCR.use_cassette('80202') do
      include_examples "a valid location", "80020"
    end
    VCR.use_cassette('1600_pennsylvania') do
      include_examples "a valid location", "1600 Pennsylvania Ave NW, Washington, DC 20500"
    end

    context 'when the location is invalid' do
      it 'returns nil' do
        VCR.use_cassette('bad_address') do
          coordinates = subject.call('advj 444kh bsddv')

          expect(coordinates).to be_nil
        end
      end
    end
  end
end
