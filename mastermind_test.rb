require 'test/unit'
require './mastermind.rb'

class MastermindTest < Test::Unit::TestCase

  def test_add_to_guess_row
    board = Board.new
    board.add_to_guess_row("rgby")
    assert_equal(board.guess_row, ["\e[0;31;49m■\e[0m", "\e[0;32;49m■\e[0m", "\e[0;30;49m■\e[0m", "\e[0;33;49m■\e[0m"])
  end

end
