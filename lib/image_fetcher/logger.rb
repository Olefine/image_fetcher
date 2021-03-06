require 'logger'

module ImageFetcher
  class Logger
    class << self
      def init_logger(logfile)
        if File.exist?(logfile)
          @logger ||= ::Logger.new(logfile)
        else
          raise ImageFetcher::LogfileDoesNotExist, "#{logfile}"
        end
      end

      def log(message)
        @logger.add(::Logger::ERROR, message)
      end

      private :new
    end
  end
end
