require 'open-uri'
require 'fileutils'

module ImageFetcher
  module Downloaders
    class ImageDownloader
      def initialize(link_info, path)
        @link_info = link_info
        @link = link_info[:url]
        @path = path

        create_dir_path
      end

      def download!
        uniq_filename = make_uniq_filename

        unless file_already_exist?(uniq_filename)
          begin
            open(build_full_path(uniq_filename), 'wb') do |file|
              file << open(@link).read
            end
          rescue RuntimeError => e
            Logger.log(e.message)
          end
        end
      end

      private
      def file_already_exist?(uniq_filename)
        File.exist?(build_full_path(uniq_filename))
      end

      def build_full_path(filename)
        @fullpath ||= File.join(@path, filename)
      end

      def make_uniq_filename
        orig_filename = extract_filename
        unique_filename = orig_filename

        unique_filename
      end

      def extract_filename
        #FIXME get extension if not exist
        url = URI.parse(@link)
        basename = File.basename(url.path)

        unless basename =~ /(png|jpg|gif|jpeg)/
          basename = "#{basename}.#{get_ext_by_mime_type}"
        end

        basename
      end

      def get_ext_by_mime_type
        type = @link_info[:content_type].split('/')[1]
        type == 'jpeg' ? 'jpg' : type
      end

      def create_dir_path
        unless File.exist?(@path)
          FileUtils::mkdir_p @path
        end
      end
    end
  end
end
