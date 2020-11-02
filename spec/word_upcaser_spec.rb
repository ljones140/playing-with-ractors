require 'spec_helper'
require './word_upcaser.rb'

RSpec.describe WordUpcaser do
  it 'returns letters upcased' do
    expect(WordUpcaser.new.(['monkey']))
      .to contain_exactly('M', 'O', 'N', 'K', 'E', 'Y')
  end

  it 'returns letters upcased' do
    expect(WordUpcaser.new.(['monkey', 'cat']))
      .to contain_exactly('M', 'O', 'N', 'K', 'E', 'Y', 'C', 'A', 'T')
  end
end
