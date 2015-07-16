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
        uri = URI.parse(@url)
        @base_url ||= "#{uri.scheme}://#{uri.host}"
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
        if(url =~ /^\w*\:/i)
          url
        else
          Addressable::URI.join(base_url, url).normalize.to_s
        end
      end
    end
  end
end
