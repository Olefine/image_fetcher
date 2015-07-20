module ImageFetcher
  class Filters::ForbiddenFilter < Filters::BaseFilter

    private
    def self.satisfied?(image_info)
      image_info[:status_code].start_with?('2')
    end
  end
end
