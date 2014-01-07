require 'minitest/spec'
require 'minitest/autorun'
require File.join(File.dirname(__FILE__), 'character.rb')

describe Character do
  before do
    @character = Character.new
    @opponent = Character.new
  end

  it "should be a Character" do
    @character.must_be_instance_of Character
  end

  it "should be have a name" do
    @character.methods.must_include :name
  end

  it "should be able to set the name" do
    @character.name = "Bob"
    @character.name.must_equal "Bob"
  end

  it "should have an Alignment" do
    @character.methods.must_include :alignment
  end

  it "should be able to set the alignment to good, evil, or neutral" do
    [:good, :evil, :neutral].each do |alignment|
      @character.alignment = alignment
      @character.alignment.must_equal alignment
    end
    [:bad, :stupid, "hello world", 1].each do |alignment| 
      assert_raises(ArgumentError) {
        @character.alignment = alignment
      }
    end
  end

  it "should have an armor class that defaults to 10" do
    @character.armor_class.must_equal 10
  end

  it "should have hit points that default to 5" do
    @character.hit_points.must_equal 5
  end

  it "should be able to roll attack die" do
    (1..20).each do |attack|
      @character.attack attack, @opponent
    end
  end

  it "should throw an ArgumentError for invalid attack rolls" do
    [31, :stupid, 99, 0, -1].each do |attack| 
      assert_raises(ArgumentError) {
        @character.attack attack, @opponent
      }
    end
  end

  it "should be able to attack an opponent" do
    @character.attack 5, @opponent
  end

  it "hit equals true if opponent armor class is less than the attack roll" do
    (@character.attack 5, @opponent).must_equal false
    (@character.attack 12, @opponent).must_equal true
    (@character.attack 10, @opponent).must_equal true
  end

  it "should damage the oppoonent 1 point if the attack is a hit" do
    original_hp = @opponent.hit_points
    @character.attack 11, @opponent
    @opponent.hit_points.must_equal original_hp - 1
  end

  it "should deal double damage if the roll is a natural 20" do
    original_hp = @opponent.hit_points
    @character.attack 20, @opponent
    @opponent.hit_points.must_equal original_hp - 2
  end

  it "should be alive" do
    @character.is_alive?.must_equal true
  end

  it "should be dead with zero hit points" do
    @character.hit_points = 0
    @character.is_alive?.must_equal false
  end

  it "should be dead with less than zero hit points" do
    @character.hit_points = -1
    @character.is_alive?.must_equal false
  end

  it "should have abilities of strength, dexterity, constitution, wisdom, intelligence, and charisma" do
    [:strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma].each do |ability|
      @character.abilities.keys.must_include ability
      @character.abilities[ability].name.must_equal ability 
    end
  end

  it "should have abilities with a default value of 10" do
    [:strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma].each do |ability|
      @character.abilities[ability].score.must_equal 10
    end
  end

end
