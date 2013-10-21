require 'nokogiri'
require 'htmlentities'

module Tapas
  class EpisodeCollection
    attr_reader :doc, :episodes

    def initialize(feed_source)
      @doc = Nokogiri.parse(feed_source.feed)
      @episodes = parse(doc)
    end

    private

    def parse(doc)
      doc.css('item').select do |item|
        episode?(item)
      end.map do |item|
        number = item_number(item)
        title = item_title(item)
        url = item_url(item)
        description = item_description(item)
        Episode.new(number, title, description, url)
      end
    end

    def item_number(item)
      number = item.at(:title).text[/^\d+/]
      number &&= number.to_i
    end

    def item_title(item)
      title = HTMLEntities.new.decode(item.at(:title).text[/^\d*\s*:?\s*(.*)/, 1])
    end

    def item_url(item)
      item.at(:enclosure)[:url]
    end

    def item_description(item)
      text = item.at(:description).text
      doc = Nokogiri.parse(text)
      doc.at('p').text
    end

    def episode?(item)
      !!item.at(:enclosure)
    end
  end
end
