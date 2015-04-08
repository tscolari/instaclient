module Instaclient
  module Models
    class Embed
      attr_accessor :raw

      def initialize(data)
        @raw = data
      end

      def author_name
        raw["author_name"]
      end

      def title
        raw["title"]
      end

      def html
        raw["html"]
      end

      def thumbnail
        raw["thumbnail_url"]
      end

      def author_url
        raw["author_url"]
      end

      def author_id
        raw["author_id"]
      end

    end
  end
end
