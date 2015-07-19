require 'spec_helper'

describe ImageFetcher::Parser do
  let(:url) { "http://familyguy.fox-fan.ru/" }
  let(:image_info_keys) { [:url, :content_type, :content_length, :status_code] }
  subject(:parser_res) { ImageFetcher::Parser.parse(url) }

  specify do
    parser_res.each_with_index do |image_info, i|
      image_info_keys.each do |key|
        expect(image_info[key]).not_to be_nil
      end
      expect(image_info.keys).to contain_exactly(*image_info_keys), "Failed at index #{i}"
    end
  end
end
