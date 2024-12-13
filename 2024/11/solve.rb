require_relative "../utils"
include AdventOfCode::Utils

class Blinker
  def initialize()
    @seen = {}
  end

  def blink(num)
    if (cached = @seen[num])
      return cached
    end

    if num == 0
      ret = [1]
    elsif num.to_s.size.odd? 
      ret = [num*2024]
    else
      str = num.to_s
      half = str.size / 2
      ret = [str[0, half].to_i, str[half, half].to_i]
    end

    @seen[num] = ret
    ret
  end

  def rec_blink(num, level)
    return 1 if level.zero?

    if (cached = @seen[[level, num]])
      return cached
    else

    @seen[[level, num]] = (
      if num.zero?
        rec_blink(1, level-1)
      elsif num.to_s.size.odd?
        rec_blink(num * 2024, level - 1)
      else
        str = num.to_s
        half = str.size / 2
        rec_blink(str[0, half].to_i, level - 1) + rec_blink(str[half..].to_i, level - 1)
      end)
    end
  end
end

def solve(blinks)
  input = File.read(__dir__ + "/input.txt").chomp.split.map(&:to_i)
  blinker = Blinker.new

  input.sum { |i| blinker.rec_blink(i, blinks)}
end


with_timed_run do
  puts "Part 1: #{solve(25)}"
end

with_timed_run do
  puts "Part 2: #{solve(75)}"
end
