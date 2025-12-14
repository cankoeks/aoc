require "./aoc"

def find_combination(indicator, buttons)
  state = Array.new(indicator.length, 0)
  n = 1

  while true do
    n.times do
      buttons.repeated_combination(n).each do |button|
        button.each do |b|
          b.each { |x| state[x.to_i] = (state[x.to_i] + 1) % 2}
        end

        return n if state == indicator
        state = Array.new(indicator.length, 0)
      end
    end
    n += 1
  end
end


AdventOfCode.timed_run do
  part1 = 0

  AdventOfCode.read_input(:lines).each do |line|
    line = line.slice(..line.index("{")-1).split("]")
    indicator = line.first.sub("[", "").gsub("#", "1").gsub(".", "0").chars.map(&:to_i)
    buttons = line.last.gsub("(", "").gsub(")", "").split(" ").map { |x| x.gsub(",", "").chars } 
    part1 += find_combination(indicator, buttons)
  end

  puts part1
end
