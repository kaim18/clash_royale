require 'net/http'
require 'json'
require 'uri'


module ClashRoyale
  class Client
    attr_accessor :access_token
    BASE_URL = 'https://api.clashroyale.com/v1'.freeze

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end
    def http_request(path)
      url = URI.parse(BASE_URL + path)
      req = Net::HTTP::Get.new(url.path)
      req['authorization'] = "Bearer #{access_token}"
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      res = http.request(req)

      return res
    end


    def clans
      res = http_request('/clans')
      res.body
    end
    def player(tag)
      res = http_request('/players/' + tag)
      res.body
    end
  end
end