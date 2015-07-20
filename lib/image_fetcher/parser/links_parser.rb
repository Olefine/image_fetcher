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
          @pool ||= ImageFetcher::Parser::RequestSender.pool(size: 100)
          @pool.future.send_request!(absolute_url, @url)
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
