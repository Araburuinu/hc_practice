# frozen_string_literal: true

class Pokemon
  attr_reader :name, :type1, :type2, :hit_points

  def initialize(name, type1, type2, hit_points)
    @name = name
    @type1 = type1
    @type2 = type2
    @hit_points = hit_points
  end

  def main
    puts '--------------------'
    puts "なまえ: #{@name}"
    puts "タイプ: #{@type1} #{@type2}"
    puts "hp: #{@hit_points}"
    puts '--------------------'
    attack
  end

  def attack
    puts "#{@name}のこうげき！\n"
  end
end

class Pikachu < Pokemon
  def attack
    puts "#{name}の10まんボルト!\n"
  end
end

charizard = Pokemon.new('リザードン', 'ほのお', 'ひこう', 100)
charizard.main

pika = Pikachu.new('ピカチュウ', 'でんき', '', 100)
pika.main
