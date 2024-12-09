require_relative "../utils"
include AdventOfCode::Utils

def determine_direction(grid, guard_position)
  symbol = grid[guard_position[0]][guard_position[1]]

  sym_to_num = {
    "^" => 0,
    ">" => 1,
    "v" => 2,
    "<" => 3,
  }

  sym_to_num[symbol]
end

def turn_90(direction)
  (direction + 1) % 4
end

def calculate_next_position(pos, direction)
  case direction
    when 0 then [pos[0] - 1, pos[1]]
    when 1 then [pos[0], pos[1] + 1]
    when 2 then [pos[0] + 1, pos[1]]
    when 3 then [pos[0], pos[1] - 1]
  end
end

def is_valid_position?(grid, pos)
  pos[0] >= 0 && pos[0] < grid.length && pos[1] >= 0 && pos[1] < grid[0].length
end

def step(grid, guard_position, direction)
  done = false
  
  new_pos = calculate_next_position(guard_position, direction)
  
  if !is_valid_position?(grid, new_pos)
    done = true
    return [guard_position, done, direction]
  end
  
  if grid[new_pos[0]][new_pos[1]] == "#"
    direction = turn_90(direction)
    new_pos = calculate_next_position(guard_position, direction)
    
    if !is_valid_position?(grid, new_pos)
      done = true
      return [guard_position, done, direction]
    end
  end

  [new_pos, done, direction]
end

def get_next_state(grid, pos, direction)
  next_pos = calculate_next_position(pos, direction)
  
  return [pos, direction, true] unless is_valid_position?(grid, next_pos)
  
  if grid[next_pos[0]][next_pos[1]] == "#"
    new_direction = turn_90(direction)
    next_pos = calculate_next_position(pos, new_direction)
    return [pos, new_direction, true] unless is_valid_position?(grid, next_pos)
    return [pos, new_direction] if grid[next_pos[0]][next_pos[1]] == "#"
    return [next_pos, new_direction]
  end
  
  [next_pos, direction]
end


def loop?(grid, start_pos, start_direction)
  visited = Set.new
  current_pos = start_pos
  current_direction = start_direction
  
  loop do
    state = [current_pos, current_direction]
    return true if visited.include?(state)
    visited.add(state)
    
    next_state = get_next_state(grid, current_pos, current_direction)
    return false if next_state.size == 3
    
    current_pos, current_direction = next_state
  end
end

def part1
  grid = read_input(__dir__ + "/input.txt") { |f| f.chars }

  guard_position_x = grid.find_index { |row| row.include?("^") }
  guard_position_y = grid[guard_position_x].find_index { |col| col.include?("^") }
  guard_position = [guard_position_x, guard_position_y]

  visited = Hash.new(false)
  
  direction = determine_direction(grid, guard_position)
  visited[guard_position] = true

  done = false
  while !done do
    guard_position, done, direction = step(grid, guard_position, direction)
    visited[guard_position] = true
  end

  visited.keys.count
end

def part2
  grid = read_input(__dir__ + "/input.txt") { |f| f.chars }
  
  start_row = grid.find_index { |row| row.include?("^") }
  start_col = grid[start_row].find_index("^")
  start_pos = [start_row, start_col]
  start_direction = 0
  
  candidates = Set.new
  current_pos = start_pos
  current_direction = start_direction
  visited = Set.new
  
  loop do
    state = [current_pos, current_direction]
    break if visited.include?(state)
    visited.add(state)
    
    next_state = get_next_state(grid, current_pos, current_direction)
    break if next_state.size == 3
    
    current_pos, current_direction = next_state
    
    4.times do |dir|
      adj_pos = calculate_next_position(current_pos, dir)
      next unless is_valid_position?(grid, adj_pos)
      next if grid[adj_pos[0]][adj_pos[1]] == "#"
      next if adj_pos == start_pos
      
      candidates.add(adj_pos)
    end
  end
  
  count = 0
  candidates.each do |pos|
    test_grid = grid.map(&:dup)
    test_grid[pos[0]][pos[1]] = "#"
    
    count += 1 if loop?(test_grid, start_pos, start_direction)
      
  end
  
  count
end

with_timed_run do
  puts "Part 1: #{part1}"
end

with_timed_run do
  puts "Part 2: #{part2}"
end