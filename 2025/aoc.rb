require_relative "utils"

module AdventOfCode
  include AdventOfCode::Utils
  
  YEAR = "2025"
  TEST_INPUT = "test.txt"
  INPUT = "input.txt"

  module_function

  def run!(day, test)
    day ||= find_latest_day
    ENV["AOC_TEST_MODE"] = test.to_s

    file = parse_file_name(day)
    return unless file
    system("ruby #{file}")
  end
  
  def find_latest_day
    day_path = Dir.glob("*").select { |path| File.directory?(path) && path.match?(/^\d+$/) }.max_by { |day| day.to_i }
    day_path if day_path
  end
  
  def parse_file_name(day)
    file_path = "#{day}/solve.rb"
    file_path if File.exist?(file_path)
  rescue
    raise "File not found: #{file_path}"
  end

  def mode
    (ENV["AOC_TEST_MODE"] == "true") ? TEST_INPUT : INPUT
  end

  def read_input(read_mode=:lines, &block)
    dir = File.dirname(caller_locations(1, 1).first.path)
    file_path = File.join(dir, mode)
    Utils.read_input(file_path, read_mode, &block)
  end

  def timed_run
    Utils.with_timed_run do
      yield
    end
  end
end

