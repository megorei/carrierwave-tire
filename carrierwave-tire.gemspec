# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave/tire/version'

Gem::Specification.new do |spec|
  spec.name          = "carrierwave-tire"
  spec.version       = Carrierwave::Tire::VERSION
  spec.authors       = ["Dieter Pisarewski"]
  spec.email         = ["dieter.pisarewski@gmail.com"]
  spec.description   = %q{Adapter for Tire::Persistence Model which allows to use CarrierWave in the usual way}
  spec.summary       = %q{Adapter for Tire::Persistence Model which allows to use CarrierWave in the usual way}
  spec.homepage      = "http://www.megorei.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "carrierwave"
  spec.add_runtime_dependency "tire"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
