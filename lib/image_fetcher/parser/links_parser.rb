require 'uri'
require 'open-uri'
require 'nokogiri'

module ImageFetcher
  module Parser
    class LinksParser < BaseParser
      def get_images_urls
        links = filter(get_document_elements.uniq)
        links.map do |link|
          absolute_url = absolute_image_url(link)
          content_length, content_type, status_code = get_image_meta(absolute_url)
          if content_type.include? 'image'
            {
               url: absolute_url,
               content_length: content_length,
               content_type: content_type,
               status_code: status_code
            }
          end
        end
      end

      private
      def get_document_elements
        @parsed_document.xpath('//a').map { |link| link['href'] }
      end

      def filter(links)
        links.select {|link| link =~ /^(https?:\/\/)?([\da-z\.-]+)\.([\/\w \.-]*)*\/?$/ }
      end
    end
  end
end
