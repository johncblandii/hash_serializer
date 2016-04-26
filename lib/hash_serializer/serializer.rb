require 'active_support/core_ext/hash'
require 'json'

module HashSerializer
  # Serializes Ruby objects to JSON for storage in Postgres tables
  module Serializer
    # Dump the contents of hash to JSON
    #
    # Example:
    #   >> HashSerializer.dump({name: 'John'})
    #   => "{'name': 'John'}"
    #
    # @param hash [Hash]
    def self.dump(hash)
      hash.to_json
    end

    # Loads the contents of hash from JSON if hash is a String or returns the array otherwise
    #
    # Example:
    #   >> HashSerializer.load("{name: 'John'}")
    #   => {'name': 'John'}
    #
    #   >> HashSerializer.load({name: 'John'})
    #   => {'name': 'John'}
    #
    #   >> HashSerializer.load(nil)
    #   => {}
    #
    # @param hash [String, Hash]
    def self.load(hash)
      hash = JSON.parse(hash) if hash.is_a?(String)
      (hash || {}).with_indifferent_access
    end
  end
end
