require_relative './filters/base_filter'
require_relative './filters/forbidden_filter'
require_relative './filters/size_filter'
require_relative './filters/content_filter'

module ImageFetcher
  module FilterApplyer
    DEFAULT_FILTERS = %w(content forbidden size)

    def self.apply(collection)
      DEFAULT_FILTERS.each do |filter_name|
        filter_class = "ImageFetcher::Filters::#{filter_name.capitalize}Filter"
        eval(filter_class).apply(collection)
      end

      collection
    end
  end
end
