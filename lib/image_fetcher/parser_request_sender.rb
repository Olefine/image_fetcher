require 'celluloid'

module ImageFetcher
  class ParserRequestSender
    include Celluloid

    def initialize(image_src_url, referer_url)
      @image_src_url = image_src_url
      @referer_url = referer_url
    end

    def send_request!
      content_length, content_type, status_code = get_image_meta
      {
         url: @image_src_url,
         content_length: content_length,
         content_type: content_type,
         status_code: status_code
      }
    end

    private
    def get_image_meta
      _url = URI(@image_src_url)
      req = Net::HTTP::Head.new(_url.to_s, initheader = {'Referer' => @referer_url})
      res = Net::HTTP.start(_url.host, _url.port) do |http|
        http.request(req)
      end

      [res['content-length'].to_i, res['content-type'], res.code]
    rescue Timeout::Error => e
      Logger.log(e.message)
    end
  end
end
