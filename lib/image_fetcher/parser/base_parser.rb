require 'addressable/uri'

module ImageFetcher
  module Parser
    class BaseParser
      def initialize(url, document)
        @url = url
        @parsed_document = document
      end

      protected
      def get_html_page
        open(@url).read
      end

      def base_url
        @base_url ||= begin
          uri = URI.parse(@url)
          "#{uri.scheme}://#{uri.host}"
        end
      end

      def absolute_image_url(url)
        resolve_image_url(url)
      end

      def get_image_meta(src_url)
        _url = URI(src_url)
        req = Net::HTTP::Head.new(_url.to_s)
        res = Net::HTTP.start(_url.host, _url.port) do |http|
          http.request(req)
        end

        [res['content-length'].to_i, res['content-type'], res.code]
      rescue Timeout::Error => e
        Logger.log(e.message)
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
