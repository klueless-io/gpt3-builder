# frozen_string_literal: true

RSpec.describe Gpt3::Builder do
  it 'has a version number' do
    expect(Gpt3::Builder::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise Gpt3::Builder::Error, 'some message' }
      .to raise_error('some message')
  end
end
