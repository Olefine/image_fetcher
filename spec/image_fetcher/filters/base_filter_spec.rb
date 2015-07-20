require 'spec_helper'

describe ImageFetcher::Filters::BaseFilter do
  let(:collection) { double() }
  subject() { ImageFetcher::Filters::BaseFilter }

  it { respond_to :apply }
end
