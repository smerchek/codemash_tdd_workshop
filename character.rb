require File.join(File.dirname(__FILE__), 'attack.rb')
require File.join(File.dirname(__FILE__), 'ability.rb')

class Character
  attr_accessor :name, :alignment, :hit_points, :armor_class,
                :strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma
  include Attack

  def initialize
    @hit_points = 5
    @armor_class = 10
    @strength = Ability.new(:strength) 
    @dexterity = Ability.new(:dexterity)
    @constitution = Ability.new(:constitution)
    @wisdom = Ability.new(:wisdom)
    @intelligence = Ability.new(:intelligence)
    @charisma = Ability.new(:charisma)
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

  def armor_class
    @dexterity.modifier + @armor_class
  end
end

