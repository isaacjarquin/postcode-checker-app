# frozen_string_literal: true

require './spec/spec_helper'
require './app/controllers/postcode_controller'
require 'net/http'

RSpec.describe Postcode do
  subject(:request) { get '/postcode', postcode: postcode }

  context 'Given an invalid postcode' do
    let(:postcode) { 'Invalid Postcode' }

    let(:expected_response) do
      '{"code":400,"error":"Invalid Postcode"}'
    end

    it 'returns an invalid password error' do
      expect(request.body).to eql(expected_response)
    end
  end

  context 'Given a valid postcode' do
    context 'Given postcode is inside of the service area' do
      let(:postcode) { 'SE17QD' }
      let(:url) do
        "http://postcodes.io/postcodes/#{postcode}"
      end

      let(:expected_response) do
        '{"code":200,"allowed":true}'
      end

      let(:postcode_inside_area_response) do
        {
          result: {
            lsoa: 'Southwark 034A'
          }
        }.to_json
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
      skip 'does not allow the postcode' do
      end
    end
  end
end
