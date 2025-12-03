require "./aoc"

part1, part2 = 0

AdventOfCode.timed_run do
  AdventOfCode.read_input(:lines).each do |line|
    mapped_chars = line.chars.map(&:to_i)
    part1 += mapped_chars.combination(2).max.join.to_i
  end
end

puts part1

AdventOfCode.timed_run do
  AdventOfCode.read_input(:lines).each do |line|
    mapped_chars = line.chars.map(&:to_i)
    part2 += mapped_chars.combination(12).max.join.to_i
  end
end

puts part2