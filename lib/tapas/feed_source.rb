require 'open-uri'

module Tapas
  class FeedSource
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def feed
      if config.feed_file
        File.read(config.feed_file)
      elsif config.feed_url
        open(config.feed_url, http_basic_authentication: [config.username, config.password]).read
      end
    rescue OpenURI::HTTPError => e
      raise Tapas::UnauthorizedError if e.message == "401 Unauthorized"
      raise
    end
  end
end
