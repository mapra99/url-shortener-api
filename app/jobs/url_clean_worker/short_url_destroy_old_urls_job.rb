module UrlCleanWorker
  class ShortUrlDestroyOldUrlsJob < ApplicationJob
    queue_as :default

    def perform
      ShortUrl.destroy_old_urls
    end
  end
end
