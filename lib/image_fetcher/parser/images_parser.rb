module ImageFetcher
  module Parser
    class ImagesParser < BaseParser
      def get_images_urls
        get_document_elements.uniq.map do |h_img|
          absolute_url = absolute_image_url(h_img['src'])
          content_length, content_type, status_code = get_image_meta(absolute_url)
          {
             url: absolute_url,
             content_length: content_length,
             content_type: content_type,
             status_code: status_code
          }
        end
      end

      private
      def get_document_elements
        @parsed_document.search('//img').select{ |i| i['src'] }
      end
    end
  end
end
