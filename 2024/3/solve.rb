require_relative "../utils"
include AdventOfCode::Utils


def part1
  count1 = 0
  read_input(__dir__ + '/input.txt') do |line|
    pattern = /mul\((\d+),(\d+)\)/

    line.scan(pattern).each do |m|
      mul = m[0].to_i * m[1].to_i
      count1 += mul
    end
  end
  count1
end


def part2
  count2 = 0
  flag = true

  read_input(__dir__ + '/input.txt') do |line|
    pattern = /mul\(\d+,\d+\)|do\(\)|don't\(\)/

    line.scan(pattern).each do |m|
      if m =~ /do\(\)/
        flag = true
      elsif m =~ /don't\(\)/
        flag = false
      elsif flag && m =~ /mul\((\d+),(\d+)\)/
        mul = $1.to_i * $2.to_i
        count2 += mul
      end
    end
  end

  count2
end

with_timed_run do
  puts "Part 1: #{part1}"
  puts "Part 2: #{part2}"
end