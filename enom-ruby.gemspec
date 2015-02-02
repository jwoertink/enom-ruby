# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enom-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "enom-ruby"
  spec.version       = EnomRuby::VERSION
  spec.authors       = ["Jeremy Woertink"]
  spec.email         = ["jeremywoertink@gmail.com"]
  spec.summary       = %q{Ruby wrapper for the Enom API}
  spec.description   = %q{EnomRuby is a Ruby wrapper for portions of the Enom domain reseller API.}
  spec.homepage      = "https://github.com/jwoertink/enom-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "0.13.3"
  spec.add_dependency "hashie",   "3.3.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "dotenv",  "~> 1.0"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.1"
  spec.add_development_dependency "vcr",     "~> 2.9"
  spec.add_development_dependency "webmock", "~> 1.20"
end
