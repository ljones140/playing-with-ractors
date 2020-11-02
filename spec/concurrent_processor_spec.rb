require 'spec_helper'
require './concurrent_processor.rb'

RSpec.describe ConcurrentProcessor do

  class WordUpcaser
    def process(word)
      [word.chars.first.upcase, word.reverse.chop.reverse]
    end
  end

  it 'returns letters upcased' do
    expect(ConcurrentProcessor.new(WordUpcaser).(['monkey']))
      .to contain_exactly('M', 'O', 'N', 'K', 'E', 'Y')
  end

  it 'returns letters upcased' do
    expect(ConcurrentProcessor.new(WordUpcaser).(['monkey', 'cat']))
      .to contain_exactly('M', 'O', 'N', 'K', 'E', 'Y', 'C', 'A', 'T')
  end
end
