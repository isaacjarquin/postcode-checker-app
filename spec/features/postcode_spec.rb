# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe 'Postcode' do
  context 'Given a invalid postcode' do
    skip 'returns an invalid password error' do
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
