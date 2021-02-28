# frozen_string_literal: true

require 'uk_postcode'
require './app/models/postcode/area_checker'

class InvalidPostcode < StandardError; end

get '/postcode' do
  begin
    postcode = UKPostcode.parse(params[:postcode].to_s)
    raise InvalidPostcode unless postcode.valid?

    {
      code: 200,
      allowed: Postcode::AreaChecker.allowed?(postcode.to_s.delete(' '))
    }.to_json
  rescue InvalidPostcode
    { code: 400, error: 'Invalid Postcode' }.to_json
  end
end
