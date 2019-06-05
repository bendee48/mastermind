require 'colorize'

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

  # def colors
  #   [:red, :green, :yellow, :cyan, :magenta, :black].each { |color| puts '■'.colorize(color) }
  # end

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
    convert_feedback([black, white])
  end

  def convert_feedback(feedback)
    feedback_string = ""
    feedback_string << "b" * feedback[0]
    feedback_string << "w" * feedback[1]
    while feedback_string.size < 4
      feedback_string << "-"
    end
    feedback_string
  end

  def display
    board.each_slice(2) { |row| puts "%s %s %s %s | %s %s %s %s" % row.flatten }
  end

  #test
  def color_test
    String.colors.each { |color| puts '■'.colorize(color)  }
  end

end

class Player

  def initialize
    @score = 0
  end

end

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  # code to guess in game class

  def main_game
    code = board.return_row("rgyb")
    loop do
      puts "type red, green, yellow, cyan magenta, black"
      answer = gets.chomp
      guess = board.return_row(answer)
      feedback = board.return_row(board.return_feedback(guess, code))
      board.add_to_board(guess, feedback)
      board.display
    end
  end

end

# p Board.new.convert_feedback([0,3])
Game.new.main_game
# current_board = Board.new
# guess = current_board.return_guess_row("rbym")
# current_board.add_to_board(guess, ["t", "t", "t", "t"])
# guess = current_board.return_guess_row("mbgy")
# current_board.add_to_board(guess, ["x", "x", "x", "x"])
# current_board.display
