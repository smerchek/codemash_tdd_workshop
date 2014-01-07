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

  it "should be alive" do
    @character.is_alive?.must_equal true
  end

  it "should be dead with zero hit points" do
    @character.damage 5
    @character.is_alive?.must_equal false
  end

  it "should be dead with less than zero hit points" do
    @character.damage 10
    @character.is_alive?.must_equal false
  end

  it "should have abilities of strength, dexterity, constitution, wisdom, intelligence, and charisma" do
    [:strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma].each do |ability|
      @character.must_respond_to ability
      @character.send(ability).name.must_equal ability 
    end
  end

  it "should have abilities with a default value of 10" do
    [:strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma].each do |ability|
      @character.send(ability).score.must_equal 10
    end
  end

  it "should add the dexterity modifier to the armor class" do
    @character.dexterity.score = 14
    expected_armor_class = 12
    @character.armor_class.must_equal expected_armor_class
  end

  it "should add the constitution modifier to the hit point" do
    @character.constitution.score = 14
    expected_hit_points = 7
    @character.hit_points.must_equal expected_hit_points
  end

  it "constitution modifier should not bring hit points below 1" do
    @character.constitution.score = 1
    expected_hit_points = 1
    @character.hit_points.must_equal expected_hit_points
  end
end
