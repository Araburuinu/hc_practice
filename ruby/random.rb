# frozen_string_literal: true

def make_groups(members, grouping = [])
  (2..4).each { |i| grouping += members.combination(i).to_a }
  group_1 = grouping[rand(grouping.size)]
  group_2 = members - group_1
  puts "#{group_1}\n#{group_2}"
end

make_groups(%w[A B C D E F])
