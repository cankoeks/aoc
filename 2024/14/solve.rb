require_relative "../utils"
include AdventOfCode::Utils

quadrants = [0,0,0,0]
quad = 0

10_000.times do |i| 
  seen = Hash.new
  read_input(__dir__ + "/input.txt") do |l|
    parts = l.split

    p = parts[0].split('=')[1].split(',').map(&:to_i)
    v = parts[1].split('=')[1].split(',').map(&:to_i)

    px = p[0]
    py = p[1]
    vx = v[0]
    vy = v[1]

    posx = (px + vx * i) % 101
    posy = (py + vy * i) % 103

    if posx < 50 && posy < 51
      quadrants[0] += 1
    elsif posx > 50 && posy < 51 
      quadrants[1] += 1
    elsif posx < 50 && posy > 51
      quadrants[2] += 1
    elsif posx > 50 && posy > 51
      quadrants[3] += 1
    end

    seen[[posx, posy]] = true
  end

  if seen.size == 500
    puts "Tree at #{i}"
    break
  end

  if i == 100
    quad = (quadrants[0] * quadrants[1] * quadrants[2] * quadrants[3])
  end
  puts "Processing... #{i}"
end

puts quad

