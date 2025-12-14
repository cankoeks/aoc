require "./aoc"

def rectangle_area(point1, point2)
  ((point1[0] - point2[0]).abs + 1) * ((point1[1] - point2[1]).abs + 1)
end

AdventOfCode.timed_run do
  brick_coordinates = []
  AdventOfCode.read_input(:lines) { |line| brick_coordinates << line.split(",").map(&:to_i) }
  
  max_area = 0
  max_pair = []
  
  brick_coordinates.each do |brick_coordinate|
    brick_coordinates.each do |other_brick_coordinate|
      area = rectangle_area(brick_coordinate, other_brick_coordinate)
      if area > max_area
        max_area = area
        max_pair = [brick_coordinate, other_brick_coordinate]
      end
    end
  end

  puts max_area
  puts max_pair.inspect
end
