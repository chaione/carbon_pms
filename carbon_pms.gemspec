# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carbon_pms/version'

Gem::Specification.new do |spec|
  spec.name          = "carbon_pms"
  spec.version       = CarbonPms::VERSION
  spec.authors       = ["Chris Mason"]
  spec.email         = ["chris@chaione.com"]
  spec.description   = %q{Ruby client to send push messages to a Carbon PMS server.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/chaione/carbon_pms"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency 'httparty', '~> 0.10'
end
