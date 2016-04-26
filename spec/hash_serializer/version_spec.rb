require 'spec_helper'

describe HashSerializer::VERSION do
  it 'version number is correct' do
    expect(subject).to eq('0.1.0')
  end
end
