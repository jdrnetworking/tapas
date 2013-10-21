module Tapas
  class Episode < Struct.new(:number, :title, :description, :url)
    include Comparable

    def title_matches?(text)
      title.downcase.include?(text.downcase)
    end

    def description_matches?(text)
      description.downcase.include?(text.downcase)
    end

    def <=>(other)
      [number.to_i, title] <=> [other.number.to_i, other.title]
    end

    def to_s
      if number
        "%3d - %s" % [ number, title ]
      else
        "      %s" % title
      end
    end
  end
end
