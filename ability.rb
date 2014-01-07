class Ability
  attr_accessor :name, :score

  def initialize(name, score = 10)
    @name = name
    @score = score
  end
end