#!/usr/bin/env ruby

require "optparse"
require "./aoc"

options = {}

parser = OptionParser.new do |opts|
  opts.on("-t", "--test", "Run the test input"){ options[:test] = true }
  opts.on("-y", "--year YEAR", "Year to run"){ |y| options[:year] = y }
  opts.on("-d", "--day DAY", "Day to run"){ |d| options[:day] = d }
  opts.on("-h", "--help", "Show this help message") do
    puts opts
    exit
  end
end

parser.parse!

AdventOfCode.run!(options[:year], options[:day], options[:test])