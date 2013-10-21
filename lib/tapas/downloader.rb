require 'open-uri'
require 'ruby-progressbar'

module Tapas
  class Downloader
    attr_reader :episode, :config, :output, :progress_bar

    def initialize(episode, config)
      @episode = episode
      @config = config
      @output = default_output(episode, config)
    end

    def download
      open_opts = {
        http_basic_authentication: [config.username, config.password],
        content_length_proc: length_proc,
        progress_proc: progress_proc
      }
      open(episode.url, open_opts) do |download|
        File.open(output, 'wb') do |out|
          out.write download.read
        end
      end
    end

    private

    def default_output(episode, config)
      filename = "RubyTapas - %3d - %s%s" % [ episode.number, episode.title, File.extname(episode.url) ]
      File.expand_path(File.join(config.destination, filename))
    end

    def length_proc
      ->(total) {
        if total && total > 0
          @progress_bar = ProgressBar.create total: total
        end
      }
    end

    def progress_proc
      ->(size) {
        progress_bar.progress = size if progress_bar
      }
    end
  end
end
