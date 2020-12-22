# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hash_serializer/version'

Gem::Specification.new do |spec|
  spec.name          = 'hash_serializer'
  spec.version       = HashSerializer::VERSION
  spec.authors       = ['John C. Bland II']
  spec.email         = ['johncblandii@gmail.com']

  spec.summary       = 'A simple Hash to JSON serializer with some helpers to improve JSON model columns.'
  spec.description   = 'A simple Hash to JSON serializer with some helpers to improve JSON model columns.'
  spec.homepage      = 'https://github.com/johncblandii/hash_serializer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.2.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.4.8'
  spec.add_development_dependency 'guard-rspec', '~> 4.6', '>= 4.6.5'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2', '>= 1.2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.68.1'
  spec.add_development_dependency 'simplecov', '~> 0.11.2'
  spec.add_development_dependency 'yard', '~> 0.8.7.6'
  spec.add_development_dependency 'sqlite3', '~> 1.3.11'
  spec.add_development_dependency 'activerecord', '~> 4.2.6'
  spec.add_development_dependency 'activerecord-nulldb-adapter', '~> 0.3.2'
end
