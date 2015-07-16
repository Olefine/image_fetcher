require 'open-uri'
require 'tempfile'
require 'fileutils'
require 'mimemagic'
require 'addressable/uri'

module ImageFetcher
  module Downloaders
    class ImageDownloader
      def initialize(link_info, path)
        @link_info = link_info
        @link = link_info[:url]
        @path = create_dir_path(path)
      end

      def download!
        uniq_filename = make_uniq_filename

        unless file_already_exist?(uniq_filename)
          begin
            temp_file = create_tempfile(uniq_filename)
            temp_file.write(open(@link).read)

            if MimeMagic.by_path(temp_file.path).image?
              final_filepath = build_full_path(uniq_filename)
              FileUtils.cp temp_file.path, final_filepath
            end

            temp_file.unlink

          rescue Timeout::Error => e
            Logger.log(e.message)
          end
        end
      end

      private
      def create_tempfile(uniq_filename)
        base, ext = uniq_filename.split('.')
        Tempfile.new([base, ".#{ext}"])
      end

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

      def create_dir_path(path)
        site_folder = Addressable::URI.parse(@link)
        _path = File.join(path, site_folder.host)
        unless Dir.exist?(_path)
          FileUtils::mkdir_p _path
        end

        _path
      end
    end
  end
end
