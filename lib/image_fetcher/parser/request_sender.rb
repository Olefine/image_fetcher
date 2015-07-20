require 'celluloid'

module ImageFetcher
  module Parser
    class RequestSender
      include Celluloid

      def send_request!(image_src_url, referer_url)
        content_length, content_type, status_code = get_image_meta(image_src_url, referer_url)
        {
           url: image_src_url,
           content_length: content_length,
           content_type: content_type,
           status_code: status_code
        }
      end

      private
      def get_image_meta(image_src_url, referer_url)
        _url = URI(image_src_url)
        req = Net::HTTP::Head.new(_url.to_s, initheader = {'Referer' => referer_url})
        res = Net::HTTP.start(_url.host, _url.port) do |http|
          http.request(req)
        end

        [res['content-length'].to_i, res['content-type'], res.code]
      rescue Timeout::Error, Net::HTTPError => e
        Logger.log(e.message)
      end
    end
  end
end
