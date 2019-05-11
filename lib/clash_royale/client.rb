require 'net/http'
require 'json'
require 'uri'


module ClashRoyale
  class Client
    attr_accessor :acces_token
    BASE_URL = 'https://api.clashroyale.com/v1'.freeze

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end



  end
end