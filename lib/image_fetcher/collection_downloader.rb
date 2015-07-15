require_relative './downloaders/image_downloader'

module ImageFetcher
  class CollectionDownloader
    def initialize(image_infos, path)
      @image_infos = image_infos
      @path = path
    end

    def download
      @image_infos.each do |image_info|
        image_downloader = ::ImageFetcher::Downloaders::ImageDownloader.new(image_info, @path)
        image_downloader.download!
      end
    end
  end
end
