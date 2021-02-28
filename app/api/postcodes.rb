# frozen_string_literal: true

require 'json'
require 'net/http'

module Api
  # It handles the postcodes.io response
  class Postcodes
    def initialize(postcode)
      @postcode = postcode
    end

    def get
      JSON.parse(postcode_url)
    end

    private

    attr_reader :postcode

    def postcode_url
      client.get(uri)
    end

    def client
      Net::HTTP
    end

    def uri
      URI("http://postcodes.io/postcodes/#{postcode}")
    end
  end
end
