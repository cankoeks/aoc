require "./aoc"


def count_paper_rolls(grid, row, col)
  max_row = grid.length - 1
  max_col = grid[0].length - 1

  paper_roll_count = 0
  paper_roll_count += 1 if row > 0 && grid[row - 1][col] == "@" # up
  paper_roll_count += 1 if row > 0 && col > 0 && grid[row - 1][col - 1] == "@" # up left
  paper_roll_count += 1 if row > 0 && col < max_col && grid[row - 1][col + 1] == "@" # up right
  paper_roll_count += 1 if row < max_row && grid[row + 1][col] == "@" # down
  paper_roll_count += 1 if row < max_row && col > 0 && grid[row + 1][col - 1] == "@" # down left
  paper_roll_count += 1 if row < max_row && col < max_col && grid[row + 1][col + 1] == "@" # down right
  paper_roll_count += 1 if col > 0 && grid[row][col - 1] == "@" # left
  paper_roll_count += 1 if col < max_col && grid[row][col + 1] == "@" # right
  paper_roll_count
end

forkable_paper_rolls = 0

AdventOfCode.timed_run do
  grid = AdventOfCode.read_input(:grid)

  grid.each_with_index do |row, row_index|
    row.each_with_index do |col, col_index|
      if col == "@"
        paper_roll_count = count_paper_rolls(grid, row_index, col_index)
        forkable_paper_rolls += 1 if paper_roll_count < 4
      end
    end
  end

  puts forkable_paper_rolls
end

forkable_paper_rolls_part2 = 0

AdventOfCode.timed_run do
  grid = AdventOfCode.read_input(:grid)

  1000.times do
    grid.each_with_index do |row, row_index|
      found_any_forkable_paper_roll = false
      row.each_with_index do |col, col_index|
        if col == "@"
          paper_roll_count = count_paper_rolls(grid, row_index, col_index)
          if paper_roll_count < 4
            forkable_paper_rolls_part2 += 1 
            grid[row_index][col_index] = "."
            found_any_forkable_paper_roll = true
          end
        end
      end
    end

  end

  puts forkable_paper_rolls_part2
end
