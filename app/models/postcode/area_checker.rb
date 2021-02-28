# frozen_string_literal: true

require './app/models/postcode/lsoa_formatter'
require './app/api/postcodes'

module Postcode
  # It checks weather an area from the lsoa field is allowed or not
  class AreaChecker
    ALLOWED_AREAS = %w[
      Southwark
      Lambeth
    ].freeze

    def initialize(postcode)
      @postcode = postcode
    end

    def self.allowed?(postcode)
      new(postcode).allowed?
    end

    def allowed?
      ALLOWED_AREAS.include?(postcode_lsoa.area)
    end

    private

    attr_reader :postcode

    def postcode_lsoa
      LsoaFormatter.new(postcode_api.get)
    end

    def postcode_api
      ::Api::Postcodes.new(postcode)
    end
  end
end
