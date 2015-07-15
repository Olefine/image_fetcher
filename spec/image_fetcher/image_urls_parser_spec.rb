require 'spec_helper'

describe ImageFetcher::ImageUrlsParser do
  let(:good_url_with_images) { "http://familyguy.fox-fan.ru" }
  let(:good_url_without_images) { "http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html" }

  context 'when url is good' do
    context 'when html page has images' do
      it 'returns image urls' do
        parser = ImageFetcher::ImageUrlsParser.new(good_url_with_images)
        image_urls = parser.get_image_urls
        expect(image_urls).not_to be_empty
      end

      context "when html page hasn't images" do
        it 'return empty array' do
          parser = ImageFetcher::ImageUrlsParser.new(good_url_without_images)
          image_urls = parser.get_image_urls
          expect(image_urls).to be_empty
        end
      end
    end
  end
end
