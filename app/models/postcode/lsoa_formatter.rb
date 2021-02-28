# frozen_string_literal: true

module Postcode
  # It formats the lsoa field to split it in two, area and code
  class LsoaFormatter
    def initialize(postcode_api_response)
      @postcode_api_response = postcode_api_response
    end

    def area
      lsoa_splitted.take(lsoa_splitted.size - 1).join(' ')
    rescue StandardError
      'No result'
    end

    def code
      lsoa_splitted.last
    rescue StandardError
      'No result'
    end

    private

    attr_reader :postcode_api_response

    def lsoa_splitted
      lsoa.split(' ')
    end

    def lsoa
      result.fetch('lsoa')
    end

    def result
      postcode_api_response.fetch('result')
    end
  end
end
