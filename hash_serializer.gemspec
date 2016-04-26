# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hash_serializer/version'

Gem::Specification.new do |spec|
  spec.name          = 'hash_serializer'
  spec.version       = HashSerializer::VERSION
  spec.authors       = ['John C. Bland II']
  spec.email         = ['johncblandii@gmail.com']

  spec.summary       = 'A serializer and helpers for Postgres JSON columns.'
  spec.description   = 'Stuff happens'
  spec.homepage      = 'https://github.com/johncblandii/hash_serializer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.1.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
end
