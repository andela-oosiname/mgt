# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mgt/version'

Gem::Specification.new do |spec|
  spec.name          = "mgt"
  spec.version       = Mgt::VERSION
  spec.authors       = ["Olumuyiwa Osiname"]
  spec.email         = ["olumuyiwa.osiname@andela.com"]

  spec.summary       = ["A simple mvc framework"]
  spec.description   = ["A simple mvc rack framework"]
  spec.homepage      = "https://github.com/andela-oosiname/mastermind_sname"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test",  "~> 0.6"

  spec.add_runtime_dependency "rack"
end
