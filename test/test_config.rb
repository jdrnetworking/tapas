require 'minitest_helper'
require 'tempfile'

class TestConfig < ActiveSupport::TestCase
  test 'should have default config path' do
    config = Tapas::Config.new
    refute_nil config.path
  end

  test 'should override config path' do
    config = Tapas::Config.new(path: '~/.foo')
    assert_equal '~/.foo', config.path.to_s
  end

  test 'should load configuration from config file' do
    Tempfile.open('tapas') do |tempfile|
      tempfile << <<-EOT
        username: foo
        password: bar
      EOT
      tempfile.close
      config = Tapas::Config.new(path: tempfile.path)
      assert_equal 'foo', config.username
      assert_equal 'bar', config.password
    end
  end

  test 'should override config file' do
    Tempfile.open('tapas') do |tempfile|
      tempfile << <<-EOT
        username: foo
        password: bar
      EOT
      tempfile.close
      config = Tapas::Config.new(path: tempfile.path, username: 'baz')
      assert_equal 'baz', config.username
      assert_equal 'bar', config.password
    end
  end

  test 'should return nil for unknown options' do
    config = Tapas::Config.new
    assert_nil config.foobar
  end

  test 'should set option' do
    config = Tapas::Config.new
    config.foobar = 'baz'
    assert_equal 'baz', config.foobar
  end

  test 'should delete option' do
    config = Tapas::Config.new foo: 'bar'
    assert_equal 'bar', config.foo
    config.delete_setting :foo
    assert_nil config.foo
  end
end
