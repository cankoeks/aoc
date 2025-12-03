require "./aoc"

dial = 50
part1, part2 = 0, 0

AdventOfCode.timed_run do
  AdventOfCode.read_input do |line|
    x = line.gsub("L", "-").gsub("R", "+").to_i
    old_dial = dial
    dial += x

    part2 += 1 if x < 0 && dial <= 0 && old_dial > 0
    part2 += (dial < 0 ? dial.abs : dial) / 100

    dial %= 100
    part1 += 1 if dial == 0
  end
end

puts part1
puts part2