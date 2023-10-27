# frozen_string_literal: true

require 'date'
require 'optparse'

WDAYS = %w[Mo Tu We Th Fr Sa Su]
WDAYS_WIDTH = WDAYS.length * 2 + WDAYS.length - 1

def title_and_wday(input)
  cal_title = "#{input.strftime('%B')} #{input.year}"
  puts cal_title.center(20)
  puts "#{WDAYS.join(' ')}"
end

def first_day(input)
  first_day = Date.new(input.year, input.month, 1)
  puts "#{' ' * (WDAYS_WIDTH - 2)}#{'1'.rjust(2, ' ')}" if first_day.wday.zero?
  print "#{' '.rjust((first_day.wday - 1) * 3 - 1, ' ')}#{'1'.rjust(2, ' ')} " if first_day.wday >= 1
end

def other_days(input)
  end_day = Date.new(input.year, input.month, -1)
  (2..end_day.day).each do |d|
    that_day = Date.new(input.year, input.month, d)
    adjuster = that_day.wday.zero? ? "\n" : ' '
    print "#{that_day.day.to_s.rjust(2, ' ')}#{adjuster}"
  end
  print "\n"
end

def calendar(input)
  title_and_wday(input)
  first_day(input)
  other_days(input)
end

opt = OptionParser.new
opt.on('-m') { |v| v }
opt.parse!(ARGV)

if ARGV[0].nil?
  calendar(Date.today)
elsif ARGV[0].to_i >= 1 && ARGV[0].to_i <= 12
  calendar(Date.new(Date.today.year, ARGV[0].to_i, 1))
else
  print "#{ARGV[0]} is neither a month number (1..12) nor a name"
end
