module ImageFetcher
  module Filters
    class BaseFilter
      def initialize(collection)
        @collection = collection
      end

      def apply!
        @collection.select! { |image_info| satisfied?(image_info) }
      end
    end
  end
end
