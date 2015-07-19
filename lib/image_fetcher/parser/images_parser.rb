module ImageFetcher
  module Parser
    class ImagesParser < BaseParser
      def get_images_urls
        get_document_elements.uniq.map do |h_img|
          absolute_url = absolute_image_url(h_img['src'])
          req_sender = ImageFetcher::ParserRequestSender.new(absolute_url, @url)
          req_sender.future.send_request!
        end
      end

      private
      def get_document_elements
        @parsed_document.search('//img').select{ |i| i['src'] }
      end
    end
  end
end
