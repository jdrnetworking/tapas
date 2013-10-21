require 'minitest_helper'

class TestEpisodeCollection < ActiveSupport::TestCase
  setup do
    @collection = Tapas::EpisodeCollection.new(feed_source)
  end

  test 'should generate episode list' do
    assert_equal 5, @collection.episodes.size
  end

  test 'should set episode attributes' do
    episode = @collection.episodes.first
    assert_equal 'Array Literals', episode.title
    assert_equal 5, episode.number
    assert_equal 'Composing command lines with fancy array literals.', episode.description
    assert_equal 'https://rubytapas.dpdcart.com/feed/download/38/RubyTapas005.mp4', episode.url
  end

  test 'should decode HTML entities in title' do
    episode = @collection.episodes.detect { |e| e.number == 2 }
    assert_equal 'Large Integer<Literals', episode.title
  end

  test 'should decode HTML entities in description' do
    episode = @collection.episodes.detect { |e| e.number == 2 }
    assert_equal 'How to format big numbers<so that they are readable.', episode.description
  end

  def feed_source
    stub feed: File.read(File.expand_path('../feed.xml', __FILE__))
  end
end
