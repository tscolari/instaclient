module Instaclient
  module Models
    class Media
      class InvalidResolutionError < StandardError; end
      class WrongMediaTypeError < StandardError; end

      attr_reader :raw

      def initialize(data)
        @raw = data
      end

      def id
        raw["id"]
      end

      def created_time
        Time.at(raw["created_time"].to_i)
      end

      def type
        raw["type"]
      end

      def video_url(resolution = :standard_resolution)
        raise WrongMediaTypeError.new("Image type doesn't have videos") if type == "image"
        valid_resolutions = raw["videos"].keys
        unless valid_resolutions.include?(resolution.to_s)
          raise InvalidResolutionError, "'#{resolution}' is invalid. Valid resolutions are: [#{valid_resolutions.join(', ')}]"
        end
        raw["videos"][resolution.to_s]["url"]
      end

      def image_url(resolution = :standard_resolution)
        valid_resolutions = raw["images"].keys
        unless valid_resolutions.include?(resolution.to_s)
          raise InvalidResolutionError, "'#{resolution}' is invalid. Valid resolutions are: [#{valid_resolutions.join(', ')}]"
        end
        raw["images"][resolution.to_s]["url"]
      end

      def caption
        (raw["caption"] && raw["caption"]["text"]).to_s
      end

      def link
        raw["link"]
      end

    end
  end
end
