require 'addressable/uri'
require 'celluloid'

module ImageFetcher
  module Parser
    class BaseParser
      def initialize(url, document)
        @url = url
        @parsed_document = document
      end

      def get_images_urls
      end

      private
      def base_url
        @base_url ||= begin
          uri = URI.parse(@url)
          "#{uri.scheme}://#{uri.host}"
        end
      end

      def absolute_image_url(url)
        resolve_image_url(url)
      end

      def resolve_image_url(url)
        if Addressable::URI.parse(url).host
          url
        else
          Addressable::URI.join(base_url, url).normalize.to_s
        end
      end
    end
  end
end
