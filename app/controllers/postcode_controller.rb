# frozen_string_literal: true

require 'uk_postcode'
require './app/models/postcode/area_checker'

class InvalidPostcode < StandardError; end

get '/postcode' do
  begin
    postcode = UKPostcode.parse(params[:postcode].to_s)

    raise InvalidPostcode unless postcode.valid?

    if Postcode::AreaChecker.allowed?(postcode.to_s.delete(' '))
      "Postcode #{postcode} is allowed"
    else
      "Postcode #{postcode} is not allowed"
    end
  rescue InvalidPostcode
    'Invalid Postcode'
  end
end
