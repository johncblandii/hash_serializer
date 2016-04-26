module HashSerializer
  # Helper methods for generating methods from hash keys and validating keys
  module Helpers
    # Validates a Postgres JSON hash on an ActiveRecord model does not include extra keys. It prevents user created
    # data on JSON column types.
    #
    # Example:
    #   >> validate_hash_serializer :billing_hash, %w(name address city state)
    #
    # @param hash_name [Symbol, String]
    # @param valid_keys [Array]
    #
    # @return [Array] a sorted Array of the invalid keys
    def validate_hash_serializer_keys(hash_name, valid_keys)
      return if send(hash_name).nil? # || !send("#{hash_name}_changed?")

      invalid_keys = send(hash_name).keys.map(&:to_s) - valid_keys.map(&:to_s)
      return if invalid_keys.empty?

      invalid_keys.sort
    end

    # Creates ActiveRecord model methods for a Postgres JSON hash
    #
    # Example:
    #   >> store_accessor_with_prefix :stripe_oauth_fields, 'stripe_connect', VALID_STRIPE_OAUTH_FIELDS
    #
    # @param hash [Hash]
    # @param prefix [String] prefix for the generated methods
    # @param keys [Array] array of strings to create methods
    def hash_accessor_with_prefix(hash, prefix, *keys)
      Array(keys).flatten.each do |key|
        prefixed_key = "#{prefix}_#{key}"

        # Ex - billing_token=
        create_setter_methods(hash, prefixed_key, key)

        # Ex - billing_token
        create_getters(hash, prefixed_key, key)

        # Ex - billing_token_changed?
        create_changed_methods(prefixed_key)
      end
    end

    protected

    def create_method(name, &block)
      self.class.send(:define_method, name, &block)
    end

    # Creates setter methods with the prefixed name and adds @*_changed properties, if the value changed,
    # and calls [hash]_will_change! to signify the hash has updated
    #
    # @param hash [Hash]
    # @param prefixed_key [String] the hash key with the desired prefix
    # @param key [String] the non-prefixed hash key
    def create_setter_methods(hash, prefixed_key, key)
      create_method("#{prefixed_key}=") do |value|
        # Set a variable to track whether the value changed
        instance_variable_set("@#{prefixed_key}_changed", true) if send(hash)[key] != value

        # Store the value
        send(hash)[key] = value
        send("#{hash}_will_change!") if respond_to? "#{hash}_will_change!".to_sym
      end
    end

    # Creates prefixed getter methods to access the hash value
    #
    # @param hash [Hash]
    # @param prefixed_key [String] the hash key with the desired prefix
    # @param key [String] the non-prefixed hash key
    def create_getters(hash, prefixed_key, key)
      create_method(prefixed_key) do
        send(hash)[key]
      end
    end

    # Creates *_changed? methods referencing the @*_changed property created in create_setter_methods
    #
    # @param prefixed_key [String] the hash key with the desired prefix
    def create_changed_methods(prefixed_key)
      create_method("#{prefixed_key}_changed?") do
        instance_variable_get("@#{prefixed_key}_changed") == true
      end
    end
  end
end
