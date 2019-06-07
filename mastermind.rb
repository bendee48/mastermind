require 'colorize'
require './textable'

class Board
  attr_accessor :board, :colors

  def initialize
    @board = []
    @colors = {'r' => :red, 'g' => :green, 'y' => :yellow,
               'c' => :cyan, 'm' => :magenta, 'b' => :black,
               'w' => :white
              }
  end

  def add_to_board(guess_row, feedback)
    board << guess_row << feedback
  end

  def return_row(letters)
    letters.chars.map do |letter| 
      colors.keys.include?(letter) ? '■'.colorize(colors[letter]) : '-'
    end    
  end

  def return_feedback(guess, code)
    black = 0
    white = 0
    used = []
    guess.each.with_index do |guess_item, ind|
      if guess_item == code[ind]
        black += 1
      else
        code.each.with_index do |code_item, ind|
          if code_item == guess_item && (code_item != guess[ind] && !used.include?(code_item))
            white += 1
            used << code_item
          end
        end
      end
    end
    feedback_to_string([black, white])
  end

  def display
    board.each_slice(2) { |row| puts "%s %s %s %s | %s %s %s %s" % row.flatten }
  end

  private

  def feedback_to_string(feedback)
    feedback_string = ""
    feedback_string << "b" * feedback[0]
    feedback_string << "w" * feedback[1]
    while feedback_string.size < 4
      feedback_string << "-"
    end
    feedback_string
  end

  # #test
  # def color_test
  #   String.colors.each { |color| puts '■'.colorize(color)  }
  # end

end

class Player

  def initialize
    @score = 0
  end

end

class Game
include Textable

  attr_accessor :board, :code

  def initialize
    @board = Board.new
    @code = %w(r g y c m b).to_a.sample(4).join
  end

  def code_for_display
    board.return_row(code)
  end

  def game_start
    introduction
    main_game
  end

  def main_game
    guess_number = 0

    loop do
      puts "Make your selection (r)ed, (g)reen, (y)ellow, (c)yan, (m)agenta, (b)lack."
      answer = gets.chomp
      (puts "That's an incorrect selection."; redo) if !guess_validated?(answer)
      guess = board.return_row(answer)
      feedback = board.return_row(board.return_feedback(guess, code_for_display))
      board.add_to_board(guess, feedback)
      board.display
      (puts "You win!"; break) if answer == code
      guess_number += 1
      (puts "You failed to guess the code :-( Game Over."; break) if guess_number > 11
      p code
    end
  end

  def guess_validated?(guess)
    guess.match?(/[rgycmb]{4}/) && guess.size == 4
  end

end

# p Board.new.convert_feedback([0,3])
Game.new.game_start
# current_board = Board.new
# guess = current_board.return_guess_row("rbym")
# current_board.add_to_board(guess, ["t", "t", "t", "t"])
# guess = current_board.return_guess_row("mbgy")
# current_board.add_to_board(guess, ["x", "x", "x", "x"])
# current_board.display
