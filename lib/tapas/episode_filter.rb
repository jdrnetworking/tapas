module Tapas
  class EpisodeFilter
    attr_reader :collection, :config

    def initialize(collection, config)
      @collection = collection
      @config = config
    end

    def episodes
      return [collection.episodes.sort.last] if config.last
      return collection.episodes.sort if config.all

      [
        by_number(config.episodes),
        title(config.title),
        description(config.description),
        search(config.search),
      ].flatten.uniq.sort
    end

    private

    def by_number(episode_numbers)
      return [] if episode_numbers.empty?

      episode_numbers.map do |episode_number|
        number(episode_number)
      end
    end

    def number(number)
      collection.episodes.detect { |episode| episode.number == number }
    end

    def title(text)
      return [] unless text
      collection.episodes.select { |episode| episode.title_matches?(text) }
    end

    def description(text)
      return [] unless text
      collection.episodes.select { |episode| episode.description_matches?(text) }
    end

    def search(text)
      return [] unless text
      [title(text), description(text)].flatten.uniq
    end
  end
end
