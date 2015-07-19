require "image_fetcher/version"
require 'image_fetcher/parser'
require 'image_fetcher/filter_applyer'
require 'image_fetcher/logger'
require 'image_fetcher/collection_downloader'
require 'addressable/uri'

module ImageFetcher
  def self.fetch(url, options)
    Logger.init_logger(options.fetch(:logfile))
    path = options.fetch(:path)

    if Addressable::URI.parse(url).host
      parser_res = Parser.parse(url)
      filter_applyer = FilterApplyer.new(parser_res)
      filter_applyer.apply!

      unless parser_res.empty?
        downloader = CollectionDownloader.new(parser_res, path, url)
        downloader.download
      end
    else
      Logger.log("Can not parse given URL - #{url}")
      return nil
    end
  end
end
