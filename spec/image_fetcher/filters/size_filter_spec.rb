require 'spec_helper'

describe ImageFetcher::Filters::SizeFilter do
  let(:collection) do
    [
      {:url=>"//", :content_length=>ImageFetcher::Filters::SizeFilter::MIN_CONTENT_LENGTH, :content_type=>"image/png", :status_code=>"200"},
      {:url=>"//", :content_length=>ImageFetcher::Filters::SizeFilter::MIN_CONTENT_LENGTH-1, :content_type=>"image/png", :status_code=>"200"}, ]
  end

  it 'reduces collection filtring by status_code' do
    filter = ImageFetcher::Filters::SizeFilter.new(collection)
    filter.apply!
    expect(collection.size).to eql(1)
  end
end
