# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wonder/version'

Gem::Specification.new do |spec|
  spec.name          = "wonder"
  spec.version       = Wonder::VERSION
  spec.authors       = ["Dan Melton"]
  spec.email         = ["melton.dan@gmail.com"]

  spec.summary       = %q{Ruby Gem to interact with the CDC Wonder API. Can be used with the command line or inside a ruby program.}
  spec.description   = %q{Ruby Gem to interact with the CDC Wonder API. Can be used with the command line or inside a ruby program. }
  spec.homepage      = "https://github.com/danmelton/wonder-ruby"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~> 0.9.1'
  spec.add_dependency 'builder'
  spec.add_dependency 'oga'
  spec.add_development_dependency "bundler", "~> 1.10.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "pry"
end
