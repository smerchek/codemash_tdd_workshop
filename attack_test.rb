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

  def attack roll
    @character.attack roll, @opponent
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
    @character.abilities[:strength].score = 14
    attack 15
    damage_dealt.must_equal expected_damage
  end

  it "should deal extra damage equal to the strength modifier" do
    strength_modifier = -2
    expected_damage = 1 + strength_modifier
    @character.abilities[:strength].score = 7
    attack 15
    damage_dealt.must_equal expected_damage
  end

end