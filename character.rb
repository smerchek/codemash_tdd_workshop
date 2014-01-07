require File.join(File.dirname(__FILE__), 'attack.rb')

class Character
  attr_accessor :name, :alignment, :hit_points, :armor_class
  include Attack

  def initialize
    @hit_points = 5
    @armor_class = 10
  end

  def alignment= alignment
    unless [:good, :evil, :neutral].include? alignment
      throw ArgumentError
    end

    @alignment = alignment
  end

  def damage damage
    @hit_points -= damage
  end

  def is_alive?
    hit_points > 0
  end
end

