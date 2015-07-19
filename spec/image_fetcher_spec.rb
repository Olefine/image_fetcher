require 'spec_helper'

describe ImageFetcher do
  let(:path) { "/tmp/spec" }
  let(:url) { "http://familyguy.fox-fan.ru/" }
  let(:files_in_path) { path + '/*'}
  let(:logfile) { '/tmp/logfile.txt' }

  it 'has a version number' do
    expect(ImageFetcher::VERSION).not_to be nil
  end

  it 'downloads images from url to path' do
    ImageFetcher.fetch(url, path: path, logfile: logfile)
    expect(Dir[files_in_path]).not_to be_empty
  end

  context 'when given url is not valid' do
    it 'not raises error' do
      wrong_url = "fake_url"
      expect{ImageFetcher.fetch(wrong_url, path: path, logfile: logfile)}.not_to raise_error
    end
  end
end
