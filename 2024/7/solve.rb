require_relative "../utils"
include AdventOfCode::Utils


def eval_operation(a, op, b)
  case op
    when "+" then a + b
    when "*" then a * b
    when "||" then (a.to_s + b.to_s).to_i
  end
end

def eval_expression(expression)
  value = 0
  while expression.length > 1 do
    a = expression.shift
    op = expression.shift
    b = expression.shift
    expression.insert(0, eval_operation(a, op, b))
  end

  expression.first
end

def part1
  count = 0
  read_input(__dir__ + "/input.txt") do |f|
    line = f.split.map(&:to_i)

    expected = line[0]
    line.delete_at(0)

    combinations = ["+", "*"].repeated_permutation(line.length - 1).to_a

    found = false
    combinations.each do |combination|
      offset = 0
      dup = line.dup
      combination.each_with_index do |op, i|
        break if found
        dup.insert(i+1+offset, op)

        if dup.length == line.length+line.length-1 && dup.length > 1
          calibration_result = eval_expression(dup)

          if calibration_result == expected
            count += calibration_result
            found = true
          end
        else
          offset += 1
        end
      end
    end
  end
  count
end

def part2
  count = 0
  read_input(__dir__ + "/input.txt") do |f|
    line = f.split.map(&:to_i)

    expected = line[0]
    line.delete_at(0)

    combinations = ["+", "*", "||"].repeated_permutation(line.length - 1).to_a

    found = false
    combinations.each do |combination|
      offset = 0
      dup = line.dup
      combination.each_with_index do |op, i|
        break if found
        dup.insert(i+1+offset, op)

        if dup.length == line.length+line.length-1 && dup.length > 1
          calibration_result = eval_expression(dup)

          if calibration_result == expected
            count += calibration_result
            found = true
          end
        else
          offset += 1
        end
      end
    end
  end
  count
end

with_timed_run do
  puts "Part 1: #{part1}"
end

with_timed_run do
  puts "Part 2: #{part2}"
end