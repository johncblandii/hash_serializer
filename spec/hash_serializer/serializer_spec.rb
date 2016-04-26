require 'spec_helper'

describe HashSerializer::Serializer do
  let(:hash) { { name: 'John' } }
  let(:indifferent_hash) { hash.with_indifferent_access }

  it 'dump' do
    expect(HashSerializer::Serializer.dump(hash)).to eq(hash.to_json)
  end

  context 'load' do
    it 'hash' do
      expect(hash).to receive(:with_indifferent_access).and_return(indifferent_hash)

      expect(HashSerializer::Serializer.load(hash)).to eq(indifferent_hash)
    end

    it 'JSON string' do
      expect(HashSerializer::Serializer.load(hash.to_json)).to eq(indifferent_hash)
    end

    it 'nil' do
      expect(HashSerializer::Serializer.load(nil)).to eq({})
    end
  end
end
