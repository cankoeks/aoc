require "./aoc"
require "set"

def euclidean_distance(point1, point2)
  Math.sqrt((point1[0] - point2[0])**2 + (point1[1] - point2[1])**2 + (point1[2] - point2[2])**2)
end

def calculate_distances(box, boxes, distances)
  boxes.each do |other_box|
    next if box == other_box
    distance = euclidean_distance(box, other_box)
    distances[distance] << [box, other_box] unless distances[distance].include?([box, other_box]) || distances[distance].include?([other_box, box])
  end

  return distances
end

AdventOfCode.timed_run do
  boxes = []
  distances = Hash.new { |h, k| h[k] = [] } # distance -> [box1, box2]
  AdventOfCode.read_input(:lines) { |line| boxes << line.split(",").map(&:to_i) } 
  boxes.each { |box| distances = calculate_distances(box, boxes, distances) }
  distances = distances.sort_by { |distance, boxes| distance }


  circuits = []

  distances.first(1000).each do |distance, box_pairs|
    box_pairs.each do |box|
      box1, box2 = box

      circuit1_index = circuits.find_index { |circuit| circuit.include?(box1) }
      circuit2_index = circuits.find_index { |circuit| circuit.include?(box2) }

      if circuit1_index && circuit2_index
        if circuit1_index != circuit2_index
          circuits[circuit1_index].merge(circuits[circuit2_index])
          circuits.delete_at(circuit2_index)
        end
      elsif circuit1_index
        circuits[circuit1_index].add(box2)
      elsif circuit2_index
        circuits[circuit2_index].add(box1)
      else
        circuits << Set.new([box1, box2])
      end
    end
  end

  require "pry"; binding.pry
  puts circuits.sort_by { |s| s.size }.reverse[..2].map(&:size).reduce(:*)
end
