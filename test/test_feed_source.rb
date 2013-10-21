require 'minitest_helper'

class TestFeedSource < ActiveSupport::TestCase
  test 'should read local file' do
    config = Struct.new(:feed_file).new('foo_file')
    source = Tapas::FeedSource.new(config)
    File.expects(:read).with('foo_file').returns('bar')
    assert_equal 'bar', source.feed
  end

  test 'should fetch authenticated feed url' do
    config = Struct.new(:feed_file, :feed_url, :username, :password).new(nil, 'foo_url', 'user', 'pass')
    source = Tapas::FeedSource.new(config)
    source.expects(:open).with('foo_url', http_basic_authentication: ['user', 'pass']).returns(StringIO.new('baz'))
    assert_equal 'baz', source.feed
  end
end
