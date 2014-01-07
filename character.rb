class Character
  attr_accessor :name, :alignment

  def alignment= alignment
    unless [:good, :evil, :neutral].include? alignment
      throw ArgumentError
    end

    @alignment = alignment
  end

  def armor_class
    10
  end

  def hit_points
    5
  end

  def attack roll, opponent
    if roll < 1 || roll > 20
      throw ArgumentError
    end

    roll >= opponent.armor_class
  end

end

