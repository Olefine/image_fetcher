require 'open-uri'
require 'tempfile'
require 'fileutils'
require 'mimemagic'
require 'addressable/uri'

module ImageFetcher
  module Downloaders
    class ImageDownloader
      include Celluloid

      def self.async_download(link_info, path, url)
        new(link_info, path, url).async.download
      end

      def initialize(link_info, path, url)
        @link_info = link_info
        @link = link_info[:url]
        @path = create_dir_path(path)
        @page_url = url
      end

      def download
        return if file_already_exist?(extract_filename)
        begin
          temp_file = create_tempfile
          temp_file.write(open(@link, 'Referer' => @page_url).read)

          if MimeMagic.by_path(temp_file.path).image?
            FileUtils.cp temp_file.path, build_full_path
          end

          temp_file.unlink
        rescue Timeout::Error, Net::HTTPError => e
          Logger.log(e.message)
        end
      end

      private
      def create_tempfile
        base, ext = @filename.split('.')
        Tempfile.new(["#{base}_#{Time.now.to_f}", ".#{ext}"])
      end

      def file_already_exist?(uniq_filename)
        File.exist?(build_full_path)
      end

      def build_full_path
        @fullpath ||= File.join(@path, @filename)
      end

      def extract_filename
        @filename ||= begin
          url = URI.parse(@link)
          basename = File.basename(url.path)

          unless basename =~ /(png|jpg|gif|jpeg)/
            basename = "#{basename}.#{get_ext_by_mime_type}"
          end

          basename
        end
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
