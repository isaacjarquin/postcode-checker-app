# frozen_string_literal: true

require './spec/spec_helper'
require './app/controllers/postcode_controller'
require 'net/http'

RSpec.describe Postcode do # rubocop:disable Metrics/BlockLength
  subject(:request) { get '/postcode', postcode: postcode }

  context 'Given an invalid postcode' do
    let(:postcode) { 'Invalid Postcode' }

    let(:expected_response) do
      'Invalid Postcode'
    end

    it 'returns an invalid password error' do
      expect(request.body).to eql(expected_response)
    end
  end

  context 'Given a valid postcode' do # rubocop:disable Metrics/BlockLength
    context 'Given postcode is inside of the service area' do
      let(:postcode) { 'SE17QD' }
      let(:url) do
        "http://postcodes.io/postcodes/#{postcode}"
      end

      let(:expected_response) do
        'Postcode SE1 7QD is allowed'
      end

      let(:postcode_inside_area_response) do
        File.read('./spec/mock/api/responses/postcode_inside_area_response.json')
      end

      before do
        allow(Net::HTTP).to receive(:get)
          .with(URI(url))
          .and_return(postcode_inside_area_response)
      end

      it 'allow the postcode' do
        expect(request.body).to eql(expected_response)
      end
    end

    context 'Given postcode is outside of the service area' do
      let(:postcode) { 'SW200JN' }

      let(:url) do
        "http://postcodes.io/postcodes/#{postcode}"
      end

      let(:expected_response) do
        'Postcode SW20 0JN is not allowed'
      end

      let(:postcode_outside_area_response) do
        File.read('./spec/mock/api/responses/postcode_outside_area_response.json')
      end

      before do
        allow(Net::HTTP).to receive(:get)
          .with(URI(url))
          .and_return(postcode_outside_area_response)
      end

      it 'does not allow the postcode' do
        expect(request.body).to eql(expected_response)
      end
    end
  end
end
