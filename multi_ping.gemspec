# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multi_ping/version'

Gem::Specification.new do |spec|
  spec.name          = "multi_ping"
  spec.version       = MultiPing::VERSION
  spec.authors       = ["genewoo"]
  spec.email         = ["genewoo_AT_gmail.com"]

  spec.summary       = %q{Ping Multiple Nodes Concurrently}
  spec.description   = %q{Check network quality by sending ICMP package concurrently.}
  spec.homepage      = "https://github.com/genewoo/multi_ping"
  spec.license       = "MIT"

  spec.required_ruby_version     = '>= 2.2.2'
  spec.required_rubygems_version = '>= 1.8.11'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('net-ping', '>= 1.7.6')
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
end
