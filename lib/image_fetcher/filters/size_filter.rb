module ImageFetcher
  class Filters::SizeFilter < Filters::BaseFilter
    MIN_CONTENT_LENGTH = 5120

    private
    def satisfied?(image_info)
      image_info[:content_length] >= MIN_CONTENT_LENGTH ? true : false
    end
  end
end
