require 'minitest/spec'
require 'minitest/autorun'
require File.join(File.dirname(__FILE__), 'ability.rb')

describe Ability do
  before do
    @ability = Ability.new(:test)
  end

  it "should have a default value of 10" do
    @ability.score.must_equal 10
  end

  it "should have a value between 1 and 20 inclusive" do
    (1..20).each do |i|
      @ability.score = i
      @ability.score.must_equal i
    end
    [0, -1, 21].each do |i|
      assert_raises(ArgumentError) {
        @ability.score = i
      }
    end
  end

  it "should have a modifier based on the score" do
    scores = 
    [
      [1, -5],
      [2, -4],
      [3, -4],
      [4, -3],
      [5, -3],
      [6, -2],
      [7, -2],
      [8, -1],
      [9, -1],
      [10, 0],
      [11, 0],
      [12, 1],
      [13, 1],
      [14, 2],
      [15, 2],
      [16, 3],
      [17, 3],
      [18, 4],
      [19, 4],
      [20, 5]
    ]
    scores.each do |arr|
      Ability.new(:test, arr[0]).modifier.must_equal arr[1]
    end
  end
end