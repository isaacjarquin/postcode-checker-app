# frozen_string_literal: true

require './spec/spec_helper'
require './app/models/postcode/area_checker'

describe Postcode::AreaChecker do
  subject(:allowed?) { described_class.allowed?(postcode) }

  let(:api_postcodes) do
    double(Api::Postcodes, get: double)
  end

  let(:lsoa_formatter) do
    double(Postcode::LsoaFormatter, area: area)
  end

  before do
    allow(::Api::Postcodes).to receive(:new)
      .with(postcode)
      .and_return(api_postcodes)

    allow(Postcode::LsoaFormatter).to receive(:new)
      .with(api_postcodes.get)
      .and_return(lsoa_formatter)
  end

  context 'Given postcode is outside of allowed areas' do
    let(:postcode) { 'SW200JN' }
    let(:area) { 'Merton' }

    it 'is not allowed' do
      expect(allowed?).to eql(false)
    end
  end

  context 'Given postcode is inside the allawed areas' do
    describe 'postcode from Southwark area' do
      let(:postcode) { 'SE17QD' }
      let(:area) { 'Southwark' }

      it 'is allowed' do
        expect(allowed?).to eql(true)
      end
    end

    describe 'postcode from Lambeth area' do
      let(:postcode) { 'SE17LS' }
      let(:area) { 'Lambeth' }

      it 'is allowed' do
        expect(allowed?).to eql(true)
      end
    end
  end
end
