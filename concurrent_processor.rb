class ConcurrentProcessor

  def initialize(strategy)
    @strategy = strategy
    @results = []
    @workers = []
  end

  def call(jobs)
    jobs.map { |work| send_work(work) }

    until @workers.empty? do
      r, output = Ractor.select(*@workers)
      @workers.delete(r)
      @results << output.first
      send_work(output[1]) unless output[1].empty?
    end

    @results
  end

  def send_work(work)
    @workers << Ractor.new(@strategy) do |strategy|
      Ractor.yield strategy.new.process(Ractor.recv)
    end

    @workers.map { |worker|
      Ractor.new(worker, work) do |worker, work|
        worker << work
      end
    }
  end
end
