class Ability
  attr_accessor :name, :score

  def initialize(name, score = 10)
    @name = name
    @score = score
  end

  def score= score
    unless (1..20).include? score
       throw ArgumentError
     end
     @score = score
  end

  def modifier
    (@score - 10)/2
  end
end