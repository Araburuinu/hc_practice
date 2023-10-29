# frozen_string_literal: true

require 'date'
require 'optparse'

WDAYS = %w[Mo Tu We Th Fr Sa Su]
WDAYS_WIDTH = WDAYS.length * 2 + WDAYS.length - 1

def title_and_wday(input)
  cal_title = "#{input.strftime('%B')} #{input.year}"
  puts cal_title.center(WDAYS_WIDTH)
  puts "#{WDAYS.join(' ')}"
end

def create_blank(input)
  first_day = Date.new(input.year, input.month, 1)
  print "#{' ' * (WDAYS_WIDTH - 2)}" if first_day.wday.zero?
  print "#{' '.rjust((first_day.wday - 1) * 3)}" if first_day.wday >= 2
end

def create_days(input)
  end_day = Date.new(input.year, input.month, -1)
  (1..end_day.day).each do |d|
    that_day = Date.new(input.year, input.month, d)
    adjuster = that_day.wday.zero? ? "\n" : ' '
    print "#{that_day.day.to_s.rjust(2, ' ')}#{adjuster}"
  end
  print "\n"
end

def calendar(input)
  title_and_wday(input)
  create_blank(input)
  create_days(input)
end

opt = OptionParser.new
opt.on('-m') { |v| v }
opt.parse!(ARGV)

if ARGV[0].nil?
  calendar(Date.today)
elsif (1..12).cover?(ARGV[0].to_i)
  calendar(Date.new(Date.today.year, ARGV[0].to_i, 1))
else
  puts "#{ARGV[0]} is neither a month number (1..12) nor a name"
end