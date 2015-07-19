require 'spec_helper'

describe ImageFetcher::Parser::LinksParser do
  it 'respond to #get_images_urls' do
    document = double()
    url = double()
    parser = ImageFetcher::Parser::LinksParser.new(url, document)
    expect(parser).to respond_to(:get_images_urls)
  end
end
