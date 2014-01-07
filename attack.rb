module Attack
  def attack roll, opponent
    if roll < 1 || roll > 20
      throw ArgumentError
    end

    if roll >= opponent.armor_class
      opponent.damage calculate_damage(roll, opponent)
    end

    roll >= opponent.armor_class
  end

  def calculate_damage roll, opponent
    damage = 1

    if roll == 20
      damage = damage * 2
    end

    damage
  end
end