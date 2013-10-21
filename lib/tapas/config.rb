require 'yaml'
require 'ostruct'

module Tapas
  class Config
    attr_accessor :path
    attr_reader :config

    def initialize(args = {})
      @path = ::Pathname.new(args.delete(:path) || default_path)
      @config = default_config
      load_config(path.expand_path)
      args.each { |k,v| config[k] = v }
    end

    def default_path
      '~/.tapas'
    end

    def delete_setting(setting)
      config.delete_field setting
    end

    def method_missing(name, *args)
      if name.to_s.end_with?('=')
        key = name.to_s.gsub(/=$/, '')
        config[key] = args.first
      else
        config[name]
      end
    end

    def respond_to_missing?(name)
      true
    end

    def to_s
      max_length = config.to_h.keys.map(&:length).max
      config.each_pair.map do |setting, value|
        "%-#{max_length}s = %s" % format_setting_value(setting, value)
      end.join("\n")
    end

    private

    def default_config
      ::OpenStruct.new.tap do |config|
        config.feed_url = 'https://rubytapas.dpdcart.com/feed'
        config.destination = '.'
      end
    end

    def load_config(path)
      return unless path.exist?
      ::YAML.load_file(path).each do |setting, value|
        config[setting] = value
      end
    end

    def format_setting_value(setting, value)
      return [ setting, value ? '✓' : '✕' ] if [true, false].include?(value)

      case setting
        when :destination then [ setting, ::File.expand_path(value) ]
        when :password then [ setting, value[0,1] + '*' * (value.length - 2) + value[-1,1] ]
        else [ setting, value ]
      end
    end
  end
end
