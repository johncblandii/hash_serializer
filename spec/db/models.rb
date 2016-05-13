require 'active_record'

# Helper model for testing purposes
class CustomerWithHash < ActiveRecord::Base
  include HashSerializer::Helpers

  VALID_KEYS = %w(name zipcode).freeze
  INVALID_KEYS = %w(invalid keys).freeze
  HASH_PREFIX = 'billing_stuff'.freeze

  def initialize
    super

    @billing = {}
  end

  attr_writer(:billing)
  attr_reader(:billing)

  hash_accessor_with_prefix :billing, HASH_PREFIX, VALID_KEYS

  def billing_will_change!
  end
end
