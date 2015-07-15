module ImageFetcher
  class Logger
    class << self
      def get_logger(filename)
        self.new(filename)
      end

      private :new
    end

    def initialize(filename)
      @filename = filename
      @file = File.open(filename, 'a')
    end

    def watch(error_strategy)
      yield if block_given?
    rescue RuntimeError => e
      puts "error"
    end
  end
end
