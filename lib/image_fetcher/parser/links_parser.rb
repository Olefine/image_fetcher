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
          req_sender = ImageFetcher::ParserRequestSender.new(absolute_url, @url)
          req_sender.future.send_request!
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
