# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'with_lock_version/version'

Gem::Specification.new do |spec|
  spec.name          = "with_lock_version"
  spec.version       = WithLockVersion::VERSION
  spec.authors       = ["Akira Kusumoto"]
  spec.email         = ["akirakusumo10@gmail.com"]

  spec.summary       = "Optimistic lock helper on ActiveRecord."
  spec.description   = "Optimistic lock helper on ActiveRecord."
  spec.homepage      = "https://github.com/bluerabbit/with_lock_version"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/})}
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f)}
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails"
  spec.add_development_dependency "bundler", "~> 2.1.0"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "rspec", "~> 3.0"
end
