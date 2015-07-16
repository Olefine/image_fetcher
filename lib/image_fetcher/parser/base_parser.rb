require 'uri'
require 'open-uri'
require 'nokogiri'
require 'addressable/uri'

module ImageFetcher
  module Parser
    class BaseParser
      def self.parse(url)
        parser = ImageFetcher::Parser::ImagesParser.new(url)
        parser.get_images_urls
      end

      protected
      def get_html_page
        open(@url).read
      end

      def base_url
        uri = URI.parse(@url)
        @base_url ||= "#{uri.scheme}://#{uri.host}"
      end

      def absolute_image_url(url)
        resolve_image_url(url)
      end

      def resolve_image_url(url)
        if(url =~ /^\w*\:/i)
          url
        else
          Addressable::URI.join(base_url, url).normalize.to_s
        end
      end
    end
  end
end
