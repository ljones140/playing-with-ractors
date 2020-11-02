class Worker
  def process(word)
    [word.chars.first.upcase, word.reverse.chop.reverse]
  end
end

class WordUpcaser

  def initialize
    @results = []
    @workers = []
  end

  def call(words)
    words.map { |word| send_work(word) }

    until @workers.empty? do
      r, output = Ractor.select(*@workers)
      @workers.delete(r)
      @results << output.first
      send_work(output[1]) unless output[1].empty?
    end

    @results
  end

  def send_work(word)
    @workers << Ractor.new do |word|
      Ractor.yield Worker.new.process(Ractor.recv)
    end

    @workers.map { |worker|
      Ractor.new worker, word do |worker, word|
        worker << word
      end
    }
  end
end
