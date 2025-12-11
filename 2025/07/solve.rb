require "./aoc"

AdventOfCode.timed_run do
  split_count = 0
  grid = AdventOfCode.read_input(:grid)

  grid.each_with_index do |row, row_index|
    next if row_index == 0

    row.each_with_index do |cell, cell_index|
      if grid[row_index-1][cell_index] == "S"
        grid[row_index][cell_index] = "|"
      elsif grid[row_index-1][cell_index] == "|"
        if grid[row_index][cell_index] == "^"
          grid[row_index][cell_index-1] = "|"
          grid[row_index][cell_index+1] = "|"
          split_count += 1
        else 
          grid[row_index][cell_index] = "|"
        end
      end
    end
  end

  puts "split_count: #{split_count}"
end

AdventOfCode.timed_run do
  grid = AdventOfCode.read_input(:grid)

  streams = Array.new(grid[0].size){0}
  streams[grid[0].find_index("S")] = 1

  grid.each_with_index do |row, row_index|
    row.each_with_index do |cell, cell_index|
        if cell == "^" && streams[cell_index] > 0      
          if (cell_index + 1) < streams.size
            streams[cell_index + 1] += streams[cell_index] 
          end

          if (cell_index - 1) >= 0
            streams[cell_index - 1] += streams[cell_index]
          end

          streams[cell_index] = 0
        end
      end
  end
  puts "stream_count: #{streams.sum}"
end
