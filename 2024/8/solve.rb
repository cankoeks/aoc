require_relative "../utils"
include AdventOfCode::Utils

def calculate_next_distance(p1, p2, size)
  after = [2 * p2[0] - p1[0], 2 * p2[1] - p1[1]]
  before = [2 * p1[0] - p2[0], 2 * p1[1] - p2[1]]

  result = [before, after].select { |coord| !out_of_bounds?(coord, size) }
  result.uniq
end

def calculate_distances(p1, p2, size)
  dx = p2[0] - p1[0]
  dy = p2[1] - p1[1]

  return [p1] if dx == 0 && dy == 0

  g = dx.gcd(dy)
  dx /= g
  dy /= g

  coords = []

  cur = p2.dup
  while !out_of_bounds?(cur, size)
    coords << cur.dup
    cur = [cur[0] + dx, cur[1] + dy]
  end

  cur = p1.dup
  while !out_of_bounds?(cur, size)
    coords << cur.dup
    cur = [cur[0] - dx, cur[1] - dy]
  end

  coords << p1
  coords << p2
  coords.uniq
end

def out_of_bounds?(coord, size)
  return true if coord.nil?
  row, col = coord
  row < 0 || row >= size[0] || col < 0 || col >= size[1]
end

def count_antennas(antennas)
  all_coordinates = antennas.values.flatten(1)
  unique_coords = all_coordinates.uniq
  unique_coords.size
end

def find_sym_coordinates(grid)
  coordinates = Hash.new { |h, k| h[k] = [] }

  grid.each_with_index do |row, i|
    row.each_with_index do |col, j|
      coordinates[col] << [i, j] if col != "."
    end
  end
  coordinates
end

def part1
  inp = read_input(__dir__ + "/input.txt") do |f|
    f.chars
  end

  size = [inp.size, inp.first.size]

  antennas = Hash.new { |h, k| h[k] = [] }
  coordinates = find_sym_coordinates(inp)

  coordinates.each do |k, v|
    v.combination(2).each do |p1, p2|
      calculate_next_distance(p1, p2, size).each do |coord|
        antennas[k] << coord unless antennas[k].include?(coord)
      end
    end
  end

  count_antennas(antennas)
end

def part2
  inp = read_input(__dir__ + "/input.txt") do |f|
    f.chars
  end

  size = [inp.size, inp.first.size]

  antennas = Hash.new { |h, k| h[k] = [] }
  coordinates = find_sym_coordinates(inp)

  coordinates.each do |k, v|
    v.combination(2).each do |p1, p2|
      calculate_distances(p1, p2, size).each do |coord|
        antennas[k] << coord unless antennas[k].include?(coord)
      end
    end
  end

  count_antennas(antennas)
end

with_timed_run do
  puts "Part 1: #{part1}"
end

with_timed_run do
  puts "Part 2: #{part2}"
end
