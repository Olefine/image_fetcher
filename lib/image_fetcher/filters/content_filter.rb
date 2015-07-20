module ImageFetcher
  class Filters::ContentFilter < Filters::BaseFilter
    
    private
    def self.satisfied?(image_info)
      image_info[:content_type] =~ /(?:jpeg|gif|png)/
    end
  end
end
