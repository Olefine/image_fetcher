require 'spec_helper'

describe ImageFetcher::Parser::BaseParser do
  let(:good_url_with_images) { "http://familyguy.fox-fan.ru" }
  let(:good_url_without_images) { "http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html" }

  context 'when url is good' do
    context 'when html page has images' do
      it 'returns image urls' do
        image_infos = ImageFetcher::Parser::BaseParser.parse(good_url_with_images)
        expect(image_infos).not_to be_empty
      end

      context "when html page hasn't images" do
        it 'return empty array' do
          image_infos = ImageFetcher::Parser::BaseParser.parse(good_url_without_images)
          expect(image_infos).to be_empty
        end
      end
    end
  end
end
