require_relative "../utils"
include AdventOfCode::Utils

def safe?(line)
   return false unless line.sort == line || line.sort.reverse == line

   return true if line.each_with_index.all? do |l,index|
      if line[index+1]
         distance = (l - line[index+1]).abs
         distance in 1..3
      else
         true
      end
   end
   false
end

count1 = 0
count2 = 0

with_timed_run do
   read_input(__dir__ + '/input.txt') do |l|
      l = l.split.map(&:to_i)
      count1 += 1 if safe? l

      if safe? l
         count2 += 1
      else
         (0..l.length-1).each do |i|
            line_dup = l.dup
            line_dup.delete_at(i)
            if safe? line_dup
               count2 += 1
               break
            end
         end
      end
   end

   puts "Part 1: #{count1}"
   puts "Part 2: #{count2}"
end
