require "./aoc"


AdventOfCode.timed_run do
  number_matrix = []
  grand_total = 0
  AdventOfCode.read_input(:lines).each do |line|
    unless line.include?("*")
      number_matrix << line.split.map(&:to_i)
    else
      line.split.each_with_index do |operator, index|
        problem_count = 0
        for row in number_matrix
          if operator == "*"
            if problem_count == 0
              problem_count = row[index]
            else
              problem_count *= row[index]
            end
          elsif operator == "+"
            problem_count += row[index]
          end
        end
        grand_total += problem_count
      end
    end
  end

  puts grand_total
end

AdventOfCode.timed_run do
  grand_total = 0
  number_matrix = []

  AdventOfCode.read_input(:lines, chomp: false).each do |line|
    unless line.include?("*")
      number_matrix << line.chars.map { |c| c =~ /\d/ ? c.to_i : nil }
    else
      operators = []
      line.chars.each_with_index do |char, index|
        operators << { op: char, col: index } if char == "*" || char == "+"
      end

      operators.each_with_index do |operator, index|
        start_col = operator[:col]
        end_col = index < operators.length - 1 ? operators[index + 1][:col] - 1 : number_matrix.first.length - 1

        digit_columns = (start_col..end_col).select do |col|
          number_matrix.any? { |row| row[col] }
        end

        numbers = digit_columns.reverse.map do |col|
          digits = number_matrix.map { |row| row[col] }.compact
          digits.join.to_i
        end

        grand_total += operator[:op] == "*" ? numbers.reduce(1, :*) : numbers.sum
      end
    end
  end

  puts grand_total
end