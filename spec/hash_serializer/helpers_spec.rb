require 'spec_helper'

describe HashSerializer::Helpers do
  let(:hash) { { name: 'John C. Bland II', zipcode: 78_377 } }

  subject { CustomerWithHash.new }

  context 'validate_hash_serializer_keys' do
    it 'should return invalid keys' do
      hash['invalid'] = true
      hash['keys'] = false

      subject.billing = hash

      errors = subject.validate_hash_serializer_keys(:billing, CustomerWithHash::VALID_KEYS)

      expect(errors).to eq(CustomerWithHash::INVALID_KEYS)
    end

    it 'should return nil if no invalid keys exist' do
      expect(subject.validate_hash_serializer_keys(:billing, CustomerWithHash::VALID_KEYS)).to be_nil
    end
  end

  context 'hash_accessor_with_prefix' do
    it 'setters exist' do
      expect(subject.respond_to?(:billing_stuff_name=)).to be_truthy
      expect(subject.respond_to?(:billing_stuff_zipcode=)).to be_truthy
    end

    it 'getters exist' do
      expect(subject.respond_to?(:billing_stuff_name)).to be_truthy
      expect(subject.respond_to?(:billing_stuff_zipcode)).to be_truthy
    end

    it 'changed? methods exist' do
      expect(subject.respond_to?(:billing_stuff_name_changed?)).to be_truthy
      expect(subject.respond_to?(:billing_stuff_zipcode_changed?)).to be_truthy
    end

    it 'methods works' do
      new_name = 'John Bland III'
      new_zipcode = 85_008

      expect(subject).to receive(:billing_will_change!).twice

      subject.billing_stuff_name = new_name
      subject.billing_stuff_zipcode = new_zipcode

      expect(subject.billing_stuff_name).to eq(new_name)
      expect(subject.billing_stuff_name_changed?).to be_truthy
      expect(subject.billing_stuff_zipcode).to eq(new_zipcode)
      expect(subject.billing_stuff_zipcode_changed?).to be_truthy
    end
  end
end
