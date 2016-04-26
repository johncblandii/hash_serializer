# HashSerializer

[![Build Status](https://api.travis-ci.org/johncblandii/hash_serializer.svg?branch=master)](http://travis-ci.org/johncblandii/hash_serializer)
[![Code Climate](https://codeclimate.com/github/johncblandii/hash_serializer/badges/gpa.svg)](https://codeclimate.com/github/johncblandii/hash_serializer)
[![Test Coverage](https://codeclimate.com/github/johncblandii/hash_serializer/badges/coverage.svg)](https://codeclimate.com/github/johncblandii/hash_serializer/coverage)
[![Issue Count](https://codeclimate.com/github/johncblandii/hash_serializer/badges/issue_count.svg)](https://codeclimate.com/github/johncblandii/hash_serializer)

A simple Hash to JSON serializer with some helpers to improve JSON model columns.

## Back Story

`HashSerializer` was birthed from the need of converting a `Hash` to and from JSON for ActiveRecord JSON columns, specifically tested on Postgres. The need grew to monitoring `Hash` changes in Rails models and creating dynamic methods for accessing the hash keys as if they were model properties. The need to prefix the columns came apparent when [Stripe](https://stripe.com) data was used in a hash and it contained keys like `id` and `object`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hash_serializer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hash_serializer

## Usage

In a model with a JSON column (ex - `billing_fields`) and serialize it:

```ruby
class Customer < ActiveRecord::Base
  serialize :billing_fields, HashSerializer
end
```

    $ customer = Customer.new(billing_fields: { name: 'John C. Bland II' })
    $ customer.billing_fields[:name]
    => John C. Bland II

This does leave the column open to any keys so it is great for development while equally terrible for security. You can utilize the `HashSerializer::Helpers` to add key validation:

```ruby
class Customer < ActiveRecord::Base
  serialize :billing_fields, HashSerializer

  validate :validate_billing_fields

  def validate_billing_fields
    invalid_keys = validate_hash_serializer :billing_hash, %w(name)
    errors.add(:billing_fields, 'has invalid keys: #{invalid_fields.join(', ')}') unless invalid_keys.empty?
  end
end
```

    $ customer = Customer.new(billing_fields: { name: 'John C. Bland II' })
    $ customer.billing_fields[:dumb_stuff] = true
    $ customer.valid?
    => false

Since some JSON keys may be best served with conflicting names to the housed model, you can also generate custom methods for each key for direct access to the hash without using hash syntax. It also allows for determining if a value has changed.

```ruby
class Customer < ActiveRecord::Base
  serialize :billing_fields, HashSerializer

  store_accessor_with_prefix :billing_fields, 'billing', %w(name)
end
```

    $ customer = Customer.new(billing_fields: { name: 'John C. Bland II' })
    $ customer.billing_name
    => 'John C. Bland II'

    $ customer.billing_name = 'John Bland III'
    $ customer.billing_name
    => 'John Bland III'

    $ customer.billing_fields[:name]
    => John Bland III

    $ customer.billing_name_changed?
    => true

    $ customer.billing_fields_changed?
    => true

**NOTE:** To hide the methods, you can include them in a Concern and call the included methods within the `included` block.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johncblandii/hash_serializer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
