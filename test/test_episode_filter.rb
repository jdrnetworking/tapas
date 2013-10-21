require 'minitest_helper'
require 'ostruct'

class TestEpisodeFilter < ActiveSupport::TestCase
  test 'should find episodes by number' do
    config = OpenStruct.new(episodes: [1])
    filter = Tapas::EpisodeFilter.new(collection, config)
    assert_equal 1, filter.episodes.size
    assert_equal 1, filter.episodes.first.number
  end

  test 'should find episode by title' do
    config = OpenStruct.new(episodes: [], title: 'Barewords')
    filter = Tapas::EpisodeFilter.new(collection, config)
    assert_equal 1, filter.episodes.size
    assert filter.episodes.first.title.include?('Barewords')
  end

  test 'should find episode by description' do
    config = OpenStruct.new(episodes: [], description: 'readable')
    filter = Tapas::EpisodeFilter.new(collection, config)
    assert_equal 1, filter.episodes.size
    assert filter.episodes.first.description.include?('readable')
  end

  test 'should find episodes by title or description' do
    config = OpenStruct.new(episodes: [], search: 'cha')
    filter = Tapas::EpisodeFilter.new(collection, config)
    assert_equal 2, filter.episodes.size
    assert filter.episodes.any? { |episode| episode.title.downcase.include?('cha') }
    assert filter.episodes.any? { |episode| episode.description.downcase.include?('cha') }
  end

  test 'should find last episode' do
    config = OpenStruct.new(last: true)
    filter = Tapas::EpisodeFilter.new(collection, config)
    assert_equal 1, filter.episodes.size
    assert_equal 5, filter.episodes.first.number
  end

  test 'should find all episodes' do
    config = OpenStruct.new(all: true)
    filter = Tapas::EpisodeFilter.new(collection, config)
    assert_equal collection.episodes.size, filter.episodes.size
  end

  def collection
    stub(episodes:
      [
        Tapas::Episode.new(5, 'Array Literals', 'Composing command lines with fancy array literals.', 'https://rubytapas.dpdcart.com/feed/download/38/RubyTapas005.mp4'),
        Tapas::Episode.new(4, 'Barewords', 'In this longer-than-usual episode, some thoughts on how to enable method logic to remain stable and unchanged while evolving and changing the source and scope of the values used by the logic.', 'https://rubytapas.dpdcart.com/feed/download/45/RubyTapas-Barewords.mp4'),
        Tapas::Episode.new(3, 'Character Literals', 'Character literal syntax in Ruby.', 'https://rubytapas.dpdcart.com/feed/download/32/RubyTapas003.mp4'),
        Tapas::Episode.new(2, 'Large Integer Literals', 'How to format big numbers so that they are readable.', 'https://rubytapas.dpdcart.com/feed/download/29/RubyTapas002.mp4'),
        Tapas::Episode.new(1, 'Binary Literals', 'In this inaugural episode, a look at a handy syntax for writing out binary numbers.', 'https://rubytapas.dpdcart.com/feed/download/25/RubyTapas001.mp4'),
      ]
    )
  end
end
