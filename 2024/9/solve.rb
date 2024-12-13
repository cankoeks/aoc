require_relative "../utils"
include AdventOfCode::Utils

def part1
  disk = read_input(__dir__ + "/input.txt") do |disk|
    file_id = 0
    blocks = []
    is_file = true

    disk.chars.each do |char|
      size = char.to_i

      if is_file
        size.times { blocks << file_id }
        file_id += 1
      else
        size.times { blocks << nil }
      end

      is_file = !is_file
    end
    blocks
  end

  disk.map do |d|
    left = 0
    right = d.length - 1
  
    while left < right
      left += 1 until left > right || d[left].nil?  
      right -= 1 until right < left || !d[right].nil?
  
      if left < right
        d[left] = d[right]
        d[right] = nil
        left += 1
        right -= 1
      end
    end
  
    d.compact!
  end


  disk.flatten!

  sum = disk.each_with_index.sum do |d, i|
    d * i
  end
  

  sum
end

def part2
  true
end

with_timed_run do
  puts "Part 1: #{part1}"
end

with_timed_run do
  puts "Part 2: #{part2}"
end
