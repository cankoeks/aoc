def can_construct?(instructions_set, target, max_instr_length)
  dp = Array.new(target.length + 1, false)
  dp[0] = true 

  (1..target.length).each do |current_index|
    start_limit = [0, current_index - max_instr_length].max
    (start_limit...current_index).each do |start_index|
      if dp[start_index]
        substring = target[start_index...current_index]
        if instructions_set.include?(substring)
          dp[current_index] = true
          break
        end
      end
    end
  end
  dp[target.length]
end

def count_ways(instructions_set, target, max_instr_length)
  dp = Array.new(target.length + 1, 0)
  dp[0] = 1

  (1..target.length).each do |current_index|
    start_limit = [0, current_index - max_instr_length].max
    (start_limit...current_index).each do |start_index|
      if dp[start_index] > 0
        substring = target[start_index...current_index]
        if instructions_set.include?(substring)
          dp[current_index] += dp[start_index]
        end
      end
    end
  end
  dp[target.length]
end

input = File.read("input.txt").chomp.split("\n\n")
instructions = input[0].split(",").map(&:strip)
strings = input[1].split("\n").map(&:strip)

max_instruction_length = instructions.map(&:length).max

puts strings.sum { |target| can_construct?(instructions, target, max_instruction_length) ? 1 : 0 }

total_ways = 0

strings.each do |target|
  ways = count_ways(instructions, target, max_instruction_length)
  total_ways += ways if ways > 0
end

puts total_ways