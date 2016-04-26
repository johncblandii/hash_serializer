require 'simplecov'

SimpleCov.start
SimpleCov.minimum_coverage 99
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'hash_serializer'
