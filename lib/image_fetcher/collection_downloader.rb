require_relative './downloaders/image_downloader'

module ImageFetcher
  class CollectionDownloader
    def self.download(image_infos, path, page_url)
      image_infos.each do |image_info|
        ImageFetcher::Downloaders::ImageDownloader.async_download(image_info, path, page_url)
      end
    end
  end
end
