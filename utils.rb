module AdventOfCode
  module Utils
    READ_MODE = :lines

    module_function

    def read_input(filename, read_mode=READ_MODE)
      filename = filename.to_s if filename.respond_to?(:to_s)
      result = case read_mode
      when :lines
        File.foreach(filename).map { |line| line.chomp }
      when :chars
        File.read(filename).chars
      when :words
        File.read(filename).split(",").map(&:chomp)
      when :grid
        File.read(filename).split("\n").map { |line| line.chomp.split("") }
      end
      
      if block_given?
        result.each { |item| yield item }
      else
        result
      end
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
