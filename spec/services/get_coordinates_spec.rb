require 'rails_helper'

RSpec.shared_examples 'a valid location' do |location|
  it 'returns coordinates for a given location string' do
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

RSpec.describe GetCoordinates do
  describe '.call' do
    subject { described_class }

    context "when given a valid location string (address, city, state, zip, etc.)" do
      VCR.use_cassette('memphis_tn') do
        include_examples "a valid location", "Memphis, TN"
      end
      VCR.use_cassette('31401') do
        include_examples "a valid location", "31401"
      end
      VCR.use_cassette('1600_pennsylvania') do
        include_examples "a valid location", "1600 Pennsylvania Ave NW, Washington, DC 20500"
      end
    end

    context 'when given an invalid location string' do
      it 'returns nil' do
        VCR.use_cassette('bad_address') do
          coordinates = subject.call('advj 444kh bsddv')

          expect(coordinates).to be_nil
        end
      end
    end
  end
end
