# frozen_string_literal: true

require './spec/spec_helper'
require './app/controllers/postcode_controller'

RSpec.describe 'Postcode' do
  subject(:request) { get '/postcode', postcode: 'Invalid Postcode' }

  context 'Given an invalid postcode' do
    let(:expected_response) do
      '{"code":400,"error":"Invalid Postcode"}'
    end

    it 'returns an invalid password error' do
      expect(request.body).to eql(expected_response)
    end
  end

  context 'Given a valid postcode' do
    context 'Given postcode is inside of the service area' do
      skip 'allow the postcode' do
      end
    end

    context 'Given postcode is outside of the service area' do
      skip 'does not allow the postcode' do
      end
    end
  end
end
