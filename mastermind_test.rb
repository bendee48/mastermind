require 'test/unit'
require './mastermind.rb'

class MastermindTest < Test::Unit::TestCase

  def test_game
    assert_equal(Game.new.test, "This is Mastermind")
  end

end
