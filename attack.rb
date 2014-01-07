module Attack
  def attack roll, opponent
    if roll < 1 || roll > 20
      throw ArgumentError
    end

    effective_roll = roll + @strength.modifier + level_bonus
    if effective_roll >= opponent.armor_class
      @experience += 10
      opponent.damage calculate_damage(roll, opponent)
    end

    effective_roll >= opponent.armor_class
  end

  def calculate_damage roll, opponent
    damage = 1 + @strength.modifier

    if roll == 20
      damage = damage * 2
    end

    [1, damage].max
  end

  def level_bonus
    level / 2
  end
end