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

end