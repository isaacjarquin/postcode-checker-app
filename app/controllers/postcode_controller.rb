# frozen_string_literal: true

require 'uk_postcode'

class InvalidPostcode < StandardError; end

get '/postcode' do
  begin
    postcode = UKPostcode.parse(params[:postcode].to_s)
    raise InvalidPostcode unless postcode.valid?
  rescue InvalidPostcode
    { code: 400, error: 'Invalid Postcode' }.to_json
  end
end
