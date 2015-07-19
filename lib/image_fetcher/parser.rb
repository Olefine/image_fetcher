require 'uri'
require 'open-uri'
require 'pry-byebug'
require 'nokogiri'
require_relative './parser_request_sender'
require_relative './parser/base_parser'
require_relative './parser/images_parser'
require_relative './parser/links_parser'

module ImageFetcher
  module Parser
    PARSERS = %w(images links)

    def self.parse(url)
      document = Nokogiri::HTML(open(url).read)
      image_infos = []

      PARSERS.each do |parser|
        parser_class = eval("ImageFetcher::Parser::#{parser.capitalize}Parser")
        parser = parser_class.new(url, document)
        image_infos << parser.get_images_urls
      end

      image_infos.flatten.map! { |i| i.value }.compact
    end
  end
end
