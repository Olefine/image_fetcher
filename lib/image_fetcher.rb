require "image_fetcher/version"
require 'image_fetcher/parser'
require 'image_fetcher/filter_applyer'
require 'image_fetcher/logger'
require 'image_fetcher/collection_downloader'

module ImageFetcher
  #NOTE You need specify absolute path
  def self.fetch(url, options)
    Logger.init_logger(options.fetch(:logfile))

    path = options.fetch(:path)

    parser_res = Parser.parse(url).compact
    filter_applyer = FilterApplyer.new(parser_res)
    filter_applyer.apply

    unless parser_res.empty?
      downloader = CollectionDownloader.new(parser_res, path)
      downloader.download
    end
  end
end
