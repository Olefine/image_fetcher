module ImageFetcher
  module Filters
    class BaseFilter
      def self.apply(collection)
        collection.select! { |image_info| satisfied?(image_info) }
      end
    end
  end
end
