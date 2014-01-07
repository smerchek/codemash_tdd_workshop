require 'minitest/spec'
require 'minitest/autorun'
require File.join(File.dirname(__FILE__), 'character.rb')

describe Attack do
  before do
    @character = Character.new
    @opponent = Character.new
    @original_opponent_hp = @opponent.hit_points
  end

  def damage_dealt 
    @original_opponent_hp - @opponent.hit_points
  end

  def attack roll, opponent = @opponent
    @character.attack roll, opponent
  end

  def experience total
    for i in (1..total/10) do
      attack 20, Character.new
    end
  end

  it "should be able to roll attack die" do
    (1..20).each do |roll|
      attack roll
    end
  end

  it "should throw an ArgumentError for invalid attack rolls" do
    [31, :stupid, 99, 0, -1].each do |roll| 
      assert_raises(ArgumentError) {
        attack roll
      }
    end
  end

  it "should be able to attack an opponent" do
    attack 5
  end

  it "hit equals true if opponent armor class is less than the attack roll" do
    (attack 5).must_equal false
    (attack 12).must_equal true
    (attack 10).must_equal true
  end

  it "should damage the oppoonent 1 point if the attack is a hit" do
    expected_damage = 1
    attack 11
    damage_dealt.must_equal expected_damage
  end

  it "should deal double damage if the roll is a natural 20" do
    expected_damage = 2
    attack 20
    damage_dealt.must_equal expected_damage
  end

  it "should deal extra damage equal to the strength modifier" do
    strength_modifier = 2
    expected_damage = 1 + strength_modifier
    @character.strength.score = 14
    attack 15
    damage_dealt.must_equal expected_damage
  end

  it "should add the strength modifier to the roll" do
    strength_modifier = -2
    @character.strength.score = 7
    attack 10
    damage_dealt.must_equal 0
  end

  it "should add the strength modifier to the roll" do
    strength_modifier = 2
    @character.strength.score = 14
    attack 10
    damage_dealt.wont_equal 0
  end

  it "should ignore strength modifier when checking for a natural 20" do
    strength_modifier = 3
    expected_damage = 4
    @character.strength.score = 17
    attack 17
    damage_dealt.must_equal expected_damage
  end

   it "should double strength modifier on critical hits" do
    strength_modifier = 2
    @character.strength.score = 15
    expected_damage = 6
    attack 20
    damage_dealt.must_equal expected_damage
  end

  it "minimum damage is always 1" do
    strength_modifier = -5
    @character.strength.score = 1
    expected_damage = 1
    attack 15
    damage_dealt.must_equal expected_damage
  end

  it "character should gain 10 experience after a successful attack" do
    attack 20
    @character.experience.must_equal 10
  end

  it "character should not gain 10 experience for an non-successful attack" do
    attack 1
    @character.experience.must_equal 0
  end

  it "should add one to attack roll for every even level achieved" do 
    experience 1000
    attack 9
    damage_dealt.wont_equal 0
  end

  it "should add one to attack roll for every even level achieved" do 
    experience 1000
    attack 8
    damage_dealt.must_equal 0
  end
end