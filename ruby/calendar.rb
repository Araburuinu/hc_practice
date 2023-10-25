# frozen_string_literal: true

require 'date'
require 'optparse'

def title_and_wday(input)
  cal_title = "#{input.strftime('%B')} #{input.year}"
  puts cal_title.center(20)
  wdays = %w[Mo Tu We Th Fr Sa Su]
  print "#{wdays.join(' ')} \n"
end

def first_day(input)
  first_day = Date.new(input.year, input.month, 1)
  if first_day.wday.zero?
    print "#{' ' * 18}#{'1'.rjust(2, ' ')}\n"
  else
    print "#{' '.rjust((first_day.wday - 1) * 3, ' ')}#{'1'.rjust(2, ' ')} "
  end
end

def other_days(input)
  end_day = Date.new(input.year, input.month, -1)
  (2..end_day.day).each do |d|
    that_day = Date.new(input.year, input.month, d)
    if that_day.wday.zero?
      print "#{that_day.day.to_s.rjust(2, ' ')}\n"
    else
      print "#{that_day.day.to_s.rjust(2, ' ')} "
    end
  end
end

def calendar(input)
  title_and_wday(input)
  first_day(input)
  other_days(input)
  print "\n"
end

opt = OptionParser.new
params = {}
opt.on('-m') { |v| params[:m] = v }
opt.parse!(ARGV)

if ARGV[0] == nil
  calendar(Date.today)
elsif ARGV[0].to_i >= 1 && ARGV[0].to_i <= 12
  calendar(Date.new(Date.today.year, ARGV[0].to_i, 1))
else
  p "#{ARGV[0]} is neither a month number (1..12) nor a name"
end
