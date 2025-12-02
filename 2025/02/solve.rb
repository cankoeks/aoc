require_relative "../utils"

def solve_part1
  AdventOfCode::Utils.with_timed_run do
    part1 = 0
    File.read("input.txt").split(",").each do |line|
      range = line.split("-").map(&:to_i)
      for i in range[0]..range[1] do
        isize = i.to_s.size
        next unless isize % 2 == 0

        first_half = i.to_s[0..isize/2-1]
        second_half = i.to_s[isize/2..-1]
        part1 += i if first_half == second_half
      end
    end
    part1
  end
end

def palindrome?(num)
  case num
  when 10..99
    num % 11 == 0
  when 100..999
    num % 111 == 0
  when 1_000..9_999
    num % 101 == 0 || num % 1_111 == 0
  when 10_000..99_999
    num % 11_111 == 0
  when 100_000..999_999
    num % 1_001 == 0 || num % 10_101 == 0 || num % 111_111 == 0
  when 1_000_000..9_999_999
    num % 1_111_111 == 0
  when 10_000_000..99_999_999
    num % 10_001 == 0 || num % 1_010_101 == 0 || num % 11_111_111 == 0
  when 100_000_000..999_999_999
    num % 1_001_001 == 0 || num % 111_111_111 == 0
  when 1_000_000_000..9_999_999_999
    num % 100_001 == 0 || num % 101_010_101 == 0 || num % 1_111_111_111 == 0
  else
    false
  end
end

def solve_part2
  AdventOfCode::Utils.with_timed_run do
    part2 = 0
    File.read("input.txt").split(",").each do |line|
      range = line.split("-").map(&:to_i)
      for i in range[0]..range[1] do
        part2 += i if palindrome?(i)
      end
    end
    part2
  end
end

puts solve_part1
puts solve_part2