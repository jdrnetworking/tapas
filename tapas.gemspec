# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tapas/version'

Gem::Specification.new do |spec|
  spec.name          = "tapas"
  spec.version       = Tapas::VERSION
  spec.authors       = ["Jon Riddle"]
  spec.email         = ["jon@jdrnetworking.com"]
  spec.description   = %q{Download RubyTapas episodes}
  spec.summary       = %q{tapas downloads the latest RubyTapas episode or episodes matching a given search term}
  spec.homepage      = "https://github.com/jdrnetworking/tapas"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "nokogiri", "~> 1.6"
  spec.add_runtime_dependency     "ruby-progressbar", "~> 1.2"
  spec.add_runtime_dependency     "htmlentities", "~> 4.3"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "activesupport", "~> 3.2.14"
  spec.add_development_dependency "minitest", "4.7.5"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-debugger"
end
