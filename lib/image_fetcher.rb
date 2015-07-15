require "image_fetcher/version"
require 'image_fetcher/parser'
require 'image_fetcher/filter_applyer'
require 'image_fetcher/logger'
require 'image_fetcher/collection_downloader'

module ImageFetcher
  #NOTE You need specify absolute path
  def self.fetch(url, options)
    # logfile = options.fetch('filename')
    # logger = Logger.get_logger(logfile)
    #
    parser_res = Parser::BaseParser.parse(url)
    filter_applyer = FilterApplyer.new(parser_res)
    filter_applyer.apply

    unless parser_res.empty?
      downloader = CollectionDownloader.new(parser_res, options[:path])
      downloader.download
    end
  end
end
