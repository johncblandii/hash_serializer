require 'active_record'

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :customer_with_hashes, force: true do |t|
    t.string :text
  end
end
