require "./aoc"


def check_ingredient_in_range(ingredient, ranges)
  ranges.each do |range|
    return true if ingredient >= range[0] && ingredient <= range[1]
  end
  false
end

ranges = []

AdventOfCode.timed_run do
  part1 = 0
 AdventOfCode.read_input(:lines).each do |line|
    if line.include?("-")
      ranges << line.split("-").map(&:to_i)
    else
      part1 += 1 if check_ingredient_in_range(line.to_i, ranges)
    end
  end
  puts part1
end

def merge_ranges(ranges)
  ranges.sort_by! { |range| range[0] }
  merged_ranges = []
  current_range = ranges[0]
  ranges[1..-1].each do |range|
    if range[0] <= current_range[1]
      current_range[1] = [current_range[1], range[1]].max
    else
      merged_ranges << current_range
      current_range = range
    end
  end
  merged_ranges << current_range
  merged_ranges
end

AdventOfCode.timed_run do
  total_ingredient_count = 0

  merge_ranges(ranges).each {|range| total_ingredient_count += range[1] - range[0] + 1 }
  puts total_ingredient_count
end