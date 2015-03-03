require 'JSON'
require 'typhoeus'

module Instaclient
  class Client
    class RequestError < StandardError; end

    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end

    def recent(user_id, items = 10)
      url = RECENT_MEDIA_ENDPOINT % { user_id: user_id, client_id: client_id, count: items }
      data = parsed_response(url)["data"]

      data.map do |media|
        Models::Media.new(media)
      end
    end

    private

    RECENT_MEDIA_ENDPOINT = "https://api.instagram.com/v1/users/%{user_id}/media/recent/?count=%{count}&client_id=%{client_id}"

    def make_request(url)
      Typhoeus.get(url).tap do |response|
        if response.code == 404
          raise RequestError, "Got 404 from instagram. Maybe wrong user_id?"
        end
      end
    end

    def parsed_response(url)
      JSON.parse(make_request(url).body)
    end

    attr_reader :client_id, :client_secret
  end
end
