require 'net/http'
require 'json'
require 'uri'

module ClashRoyale
  class Client

    attr_accessor :api_key
    BASE_URL = 'https://api.clashroyale.com/v1'.freeze

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end

    def http_request(path, options={})
      url = URI.parse(BASE_URL + path)
      url.query = URI.encode_www_form(options)
      req = Net::HTTP::Get.new url
      req['authorization'] = "Bearer #{api_key}"
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      res = http.request(req)
      return res
    end


    def search_clans(options = {})
      res = http_request('/clans', options)
      res.body
    end

    def clan_information(tag)
      res = http_request('/clans/' + tag)
      res.body
    end

    def clan_members(tag, options = {})
      res = http_request('/clans/' + tag + '/members', options)
      res.body
    end

    def clan_warlog(tag , options = {})
      res = http_request('/clans/' + tag + '/warlog', options)
      res.body
    end

    def clan_currentwar(tag)
      res = http_request('/clans/' + tag + '/currentwar')
      res.body
    end

    def player(tag)
      res = http_request('/players/' + tag)
      res.body
    end

    def player_upcomingchests(tag)
      res = http_request('/players/' + tag + '/upcomingchests')
      res.body
    end

    def player_battlelog(tag)
      res = http_request('/players/' + tag + '/battlelog')
      res.body
    end

    def search_tournaments(options = {})
      res = http_request('/tournaments', options)
      res.body
    end

    def tournament_information(tag)
      res = http_request('/tournaments/' + tag)
      res.body
    end

    def global_tournaments
      res = http_request('/globaltournaments')
      res.body
    end

    def cards
      res = http_request('/cards')
      res.body
    end

    def locations
      res = http_request('/locations')
      res.body
    end

    def location_information(tag)
      res = http_request('/locations/' + tag)
      res.body
    end

    def location_clan_ranking(tag, options = {})
      res = http_request('/locations/' + tag + '/rankings/clans', options)
      res.body
    end

    def location_player_ranking(tag, options = {})
      res = http_request('/locations/' + tag + '/rankings/players', options)
      res.body
    end

    def location_clanwar_ranking(tag, options = {})
      res = http_request('/locations/' + tag + '/rankings/clanwars', options)
      res.body
    end

  end
end
