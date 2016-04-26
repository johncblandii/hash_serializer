require 'simplecov'

SimpleCov.start
SimpleCov.minimum_coverage 99
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'hash_serializer'
