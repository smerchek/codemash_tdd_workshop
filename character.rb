require File.join(File.dirname(__FILE__), 'attack.rb')
require File.join(File.dirname(__FILE__), 'ability.rb')

class Character
  attr_accessor :name, :alignment
  attr_reader   :armor_class, :strength, :dexterity, :constitution, 
                :wisdom, :intelligence, :charisma, :experience
  include Attack

  def initialize
    @base_hit_points = 5
    @armor_class = 10
    @strength = Ability.new(:strength) 
    @dexterity = Ability.new(:dexterity)
    @constitution = Ability.new(:constitution)
    @wisdom = Ability.new(:wisdom)
    @intelligence = Ability.new(:intelligence)
    @charisma = Ability.new(:charisma)
    @damage_taken = 0
    @experience = 0
  end

  def alignment= alignment
    unless [:good, :evil, :neutral].include? alignment
      throw ArgumentError
    end

    @alignment = alignment
  end

  def damage damage
    @damage_taken += damage
  end

  def is_alive?
    hit_points > 0
  end

  def armor_class
    @dexterity.modifier + @armor_class
  end

  def max_hit_points
    [1, @constitution.modifier + @base_hit_points].max * level
  end

  def hit_points
    max_hit_points - @damage_taken
  end

  def level
    1 + @experience / 1000
  end
end

