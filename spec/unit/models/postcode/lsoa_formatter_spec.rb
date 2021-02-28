# frozen_string_literal: true

require './spec/spec_helper'
require './app/models/postcode/lsoa_formatter'

describe Postcode::LsoaFormatter do # rubocop:disable Metrics/BlockLength
  let(:lsoa_formatter) do
    described_class.new(postcode_api_response)
  end
  let(:lsoa) { 'Southwark 034A' }
  let(:postcode_api_response) do
    { 'result' => { 'lsoa' => lsoa } }
  end

  describe '#area' do
    subject(:area) { lsoa_formatter.area }

    it 'returns the lsoa code' do
      expect(area).to eql('Southwark')
    end

    context 'given a composed area' do
      let(:lsoa) { 'Hammersmith and Fulham 001A' }

      it 'returns the lsoa code' do
        expect(area).to eql('Hammersmith and Fulham')
      end
    end

    context 'given no result from api' do
      let(:postcode_api_response) do
        { 'result' => nil }
      end

      it 'returns No result' do
        expect(area).to eql('No result')
      end
    end
  end

  describe '#code' do
    subject(:code) { lsoa_formatter.code }

    it 'returns the lsoa code' do
      expect(code).to eql('034A')
    end

    context 'given no result from api' do
      let(:postcode_api_response) do
        { 'result' => nil }
      end

      it 'returns No result' do
        expect(code).to eql('No result')
      end
    end
  end
end
