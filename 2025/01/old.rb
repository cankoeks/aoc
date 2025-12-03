require_relative "../utils"

dial = 50
part1 = 0
part2 = 0

AdventOfCode::Utils.with_timed_run do
  AdventOfCode::Utils.read_input do |line|
    old_dial = dial
    x = line.gsub("L", "-").gsub("R", "+").to_i
    if x < 0
    # Left turn
      dial = (x + dial)
      if dial < 0
        if old_dial == 0
          part2 += dial.abs / 100
        else
          part2 += 1 + dial.abs / 100
        end
      elsif dial == 0
        part2 += 1
      end
      dial = dial % 100
    else
      # Right turn
      dial = (dial + x)
      part2 += dial / 100
      dial = dial % 100
    end
    part1 += 1 if dial == 0
  end
end


puts part1
puts part2