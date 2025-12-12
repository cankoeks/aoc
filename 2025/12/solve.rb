require "./aoc"

part1 = 0 

AdventOfCode.timed_run do
  lines = []
  AdventOfCode.read_input(:lines) { |line| lines << line }

  relevant_lines = lines
    .drop_while { |line| !line.start_with?("40x48") }
    .map { |line| line.split(":") }

  relevant_lines.each do |line|
    area = line.first.split("x").map { |x| x.to_i - x.to_i % 3 }.reduce(:*)
    needed_area = line.last.split.map(&:to_i).sum*9

    part1 += 1 if needed_area <= area
  end

  puts part1
end