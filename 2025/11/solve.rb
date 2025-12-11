require "./aoc"

def bfs(map, start, target, count)
  queue = [start]
  while !queue.empty?
    current = queue.shift
    count += 1 if current == target
    map[current].each { |neighbor| queue << neighbor }
  end
  count
end

# Part 1
AdventOfCode.timed_run do
  map = Hash.new { |h, k| h[k] = [] }
  AdventOfCode.read_input(:lines) do |line|
    parsed_line = line.split(":")
    start = parsed_line[0]
    nodes = parsed_line[1].split(" ")
    map[start] = nodes
  end

  paths = bfs(map, "you", "out", 0)
  puts "Part 1: #{paths}"
end


def dfs(map, start, target, count, visited)
  return 0 if visited.include?(start)

  if start == target
    return (visited.include?("fft") && visited.include?("dac")) ? 1 : 0
  end

  @cache ||= {}
  cache_key = [start, visited.include?("fft"), visited.include?("dac")]  
  return @cache[cache_key] if @cache.key?(cache_key)

  count = 0
  map[start].each do |neighbor|
    count += dfs(map, neighbor, target, count, visited + [start])
  end
  
  @cache[cache_key] = count
  count
end

# Part 2
AdventOfCode.timed_run do
  map = Hash.new { |h, k| h[k] = [] }
  AdventOfCode.read_input(:lines) do |line|
    parsed_line = line.split(":")
    start = parsed_line[0]
    nodes = parsed_line[1].split(" ")
    map[start] = nodes
  end

  paths = dfs(map, "svr", "out", 0, [])
  puts "Part 2: #{paths}"
end
