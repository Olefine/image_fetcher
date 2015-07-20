require 'spec_helper'

describe ImageFetcher::Filters::ContentFilter do
  let(:collection) do
    [
      {:url=>"//right_content_url", :content_length=>596, :content_type=>"image/png", :status_code=>"200"},
      {:url=>"//wrong_content_url", :content_length=>596, :content_type=>"application/pdf", :status_code=>"200"},
    ]
  end

  it 'reduces collection filtring by image content_type' do
    ImageFetcher::Filters::ContentFilter.apply(collection)
    expect(collection.size).to eql(1)
  end
end
