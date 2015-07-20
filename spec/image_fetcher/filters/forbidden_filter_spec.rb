require 'spec_helper'

describe ImageFetcher::Filters::ForbiddenFilter do
  let(:collection) do
    [
      {:url=>"//", :content_length=>596, :content_type=>"image/png", :status_code=>"200"},
      {:url=>"//", :content_length=>596, :content_type=>"image/png", :status_code=>"403"},
    ]
  end

  it 'reduces collection filtring by status_code' do
    ImageFetcher::Filters::ForbiddenFilter.apply!(collection)
    expect(collection.size).to eql(1)
  end
end
