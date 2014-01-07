module Attack
  def attack roll, opponent
    if roll < 1 || roll > 20
      throw ArgumentError
    end

    effective_roll = roll + calculate_strength_adjustment
    if effective_roll >= opponent.armor_class
      opponent.damage calculate_damage(roll, opponent)
    end

    effective_roll >= opponent.armor_class
  end

  def calculate_damage roll, opponent
    damage = 1 + calculate_strength_adjustment

    if roll == 20
      damage = damage * 2
    end

    damage
  end

  def calculate_strength_adjustment
    @strength.modifier
  end
end