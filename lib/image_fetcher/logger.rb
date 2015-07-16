module ImageFetcher
  class Logger
    class << self
      def init_logger(logfile)
        if File.exist?(logfile)
          @@file = logfile
        else
          raise "File doesnt exist"
        end
      end

      def log(message)
        build_logline(message)
        File.open(@@file, 'a') { |log| log.write(build_logline(message)) }
      end

      private :new

      private
      def build_logline(message)
        "#{Time.now} : #{message} \n"
      end
    end
  end
end
