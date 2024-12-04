require_relative "../utils"
include AdventOfCode::Utils

PATTERN = /(?=XMAS|SAMX)/

def horizontal(line)
  line.scan(PATTERN).sum { 1 }
end

def vertical(input)
  input.transpose.sum do |lines|
    horizontal(lines.join)
  end
end

def diagonal(input)
  count = 0
  input.map!
  input.each_with_index do |line, r|
    line.each_with_index do |char, c|
      unless (r > line.size-4 || c > input.transpose.first.size-4 || !("XS".include?(char)))  
        count += 1 if (char + input[r+1][c+1] + input[r+2][c+2] + input[r+3][c+3]) =~ PATTERN 
      end

      unless (r < 3 || c > line.size-4 || !("XS".include?(char)))
        count += 1 if (char + input[r-1][c+1] + input[r-2][c+2] + input[r-3][c+3]) =~ PATTERN
      end
    end
  end

  count
end

def mas(input)
  count = 0
  input.map!
  input.each_with_index do |line, r|
    line.each_with_index do |char, c|
      next if r.zero? || c.zero?
      next if r > input.transpose.first.size-2 || c > input.size-2
      next unless char == "A"

      cross_1 = (input[r-1][c-1] + char + input[r+1][c+1]).chars.sort
      cross_2 = (input[r+1][c-1] + char + input[r-1][c+1]).chars.sort

      count += 1 if cross_1 == cross_2 && cross_1 == "MAS".chars.sort
    end
  end

  count
end

def part1
  count = 0
  read_input(__dir__ + '/input.txt') do |l|
    count += horizontal(l)
  end
  t_input = read_input(__dir__ + '/input.txt') do |l|
    l.chars
  end

  count += vertical(t_input)
  count += diagonal(t_input)
  count
end

def part2
  input = read_input(__dir__ + '/input.txt') do |l|
    l.chars
  end
  mas(input)
end

with_timed_run do
  puts "Part 1: #{part1}"
  puts "Part 2: #{part2}"
end