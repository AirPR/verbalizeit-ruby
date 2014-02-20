# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'verbalizeit/version'

Gem::Specification.new do |spec|
  spec.name          = "verbalizeit-ruby"
  spec.version       = VerbalizeIt::VERSION
  spec.authors       = ["Ryan Eschinger"]
  spec.email         = ["ryanesc@gmail.com"]
  spec.description   = %q{Simple API wrapper for the VerbalizeIt Api}
  spec.summary       = %q{Ruby wrapper for the VerbalizeIt Api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock", "~> 1.15"
  spec.add_development_dependency "vcr", "~> 2.8.0"

  spec.add_runtime_dependency "httparty"
end
