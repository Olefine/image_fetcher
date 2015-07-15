module ImageFetcher
  module Parser
    class ImagesParser < BaseParser
      def initialize(url)
        @url = url
        @parsed_document = Nokogiri::HTML(get_html_page)
      end

      def get_images_urls
        h_imgs = @parsed_document.search('//img').select{ |i| i['src'] }
        h_imgs.uniq.map do |h_img|
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
      def get_image_meta(src_url)
        _url = URI(src_url)
        req = Net::HTTP::Head.new(_url.to_s)
        res = Net::HTTP.start(_url.host, _url.port) do |http|
          http.request(req)
        end

        [res['content-length'].to_i, res['content-type'], res.code]
      end
    end
  end
end
