module ImageFetcher
  class CommonError < StandardError; self; end
  class LogfileDoesNotExist < CommonError; end
end
