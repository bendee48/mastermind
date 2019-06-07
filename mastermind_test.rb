require 'test/unit'
require './mastermind.rb'

class MastermindTest < Test::Unit::TestCase

  def test_guess_validated
    game = Game.new
    assert_equal(game.guess_validated?("rgyb"), true)
    assert_equal(game.guess_validated?("ybcm"), true)
    assert_equal(game.guess_validated?("rrmm"), true)
    assert_not_equal(game.guess_validated?("rgyj"), true)
    assert_not_equal(game.guess_validated?("rgybm"), true)
    assert_not_equal(game.guess_validated?("bgy"), true)
  end

end
