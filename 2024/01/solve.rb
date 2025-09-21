require_relative "../utils"

first = Array.new
second = Array.new

AdventOfCode::Utils.read_input(__dir__ + '/input.txt') do |line|
  a,b = line.split.map(&:to_i)
  first << a
  second << b  
end

first.sort!
second.sort!

counter = 0
first.each_with_index { |a,i| counter += (a - second[i]).abs }
puts counter

counter = 0
hash_count = Hash.new(0)
second.each { |b| hash_count[b] += 1 } # oder frequency = second.tally
first.each { |a| counter += (a * hash_count[a]) }

#freq = second.tally
#first.each { |a| counter += (a * freq.fetch(a, 0)) }
puts counter

