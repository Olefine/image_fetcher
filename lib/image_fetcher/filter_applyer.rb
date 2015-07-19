require_relative './filters/base_filter'
require_relative './filters/forbidden_filter'
require_relative './filters/size_filter'
require_relative './filters/content_filter'

module ImageFetcher
  class FilterApplyer
    DEFAULT_FILTERS = %w(content forbidden size)

    def initialize(collection)
      @collection = collection
    end

    def apply!
      DEFAULT_FILTERS.each do |filter_name|
        filter_class = "ImageFetcher::Filters::#{filter_name.capitalize}Filter"
        filter = eval(filter_class).new(@collection)
        filter.apply!
      end

      @collection
    end
  end
end
