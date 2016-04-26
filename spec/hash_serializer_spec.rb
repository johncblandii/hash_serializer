require 'spec_helper'

describe HashSerializer do
  it 'has a version number' do
    expect(HashSerializer::VERSION).not_to be nil
  end

  it 'has the serializer included' do
    expect(HashSerializer::Serializer).not_to be nil
  end

  it 'has the helpers included' do
    expect(HashSerializer::Helpers).not_to be nil
  end
end
