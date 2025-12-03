require_relative "utils"

module AdventOfCode
  include AdventOfCode::Utils
  
  TEST_INPUT = "test.txt"
  INPUT = "input.txt"

  module_function

  def run!(year, day, test)
    year ||= find_latest_year
    day ||= find_latest_day(year)
    ENV["AOC_TEST_MODE"] = test.to_s

    file = parse_file_name(year, day)
    return unless file
    system("ruby #{file}")
  end

  def find_latest_year
    Dir.glob("20*").select { |path| File.directory?(path) }.max_by { |year| year.to_i }
  end
  
  def find_latest_day(year)
    day_path = Dir.glob("#{year}/*").select { |path| File.directory?(path) }.max_by { |day| File.basename(day).to_i }
    File.basename(day_path) if day_path
  end
  
  def parse_file_name(year, day)
    file_path = "#{year}/#{day}/solve.rb"
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