require 'minitest_helper'

class TestEpisode < ActiveSupport::TestCase
  setup do
    @episode = Tapas::Episode.new(
      5,
      'Array Literals',
      'Composing command lines with fancy array literals.',
      'https://rubytapas.dpdcart.com/feed/download/38/RubyTapas005.mp4'
    )
  end

  test 'should match title' do
    assert @episode.title_matches?('Array')
  end

  test 'should match title without case sensitivity' do
    assert @episode.title_matches?('array')
  end

  test 'should match description' do
    assert @episode.description_matches?('Composing')
  end

  test 'should match description without case sensitivity' do
    assert @episode.description_matches?('composing')
  end

  test 'should be sort by episode number first' do
    episode_2 = Tapas::Episode.new(4, 'Array Literals', '', '')
    sorted = [@episode, episode_2].sort
    assert_equal [episode_2, @episode], sorted
  end

  test 'should sort by title next' do
    episode_2 = Tapas::Episode.new(5, 'Binary Literals', '', '')
    sorted = [episode_2, @episode].sort
    assert_equal [@episode, episode_2], sorted
  end

  test 'should sort without episode number' do
    episode_2 = Tapas::Episode.new(nil, 'Binary Literals', '', '')
    sorted = [@episode, episode_2].sort
    assert_equal [episode_2, @episode], sorted
  end
end
