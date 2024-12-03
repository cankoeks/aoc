module AdventOfCode
  module Utils
    module_function

    def read_input(filename="input.txt")
      File.foreach(filename).map do |line|
        yield(line.chomp)
      end
    end

    def read_test_input(filename="test.txt")
      read_input(filename)
    end

    def with_timed_run
      start_time = Time.now
      result = yield
      end_time = Time.now
      elapsed_time = end_time - start_time
      puts "Execution time: #{elapsed_time} seconds"
      result
    end
  end
end
