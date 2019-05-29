require 'colorize'

class Board
  attr_accessor :board, :feedback_row, :colors

  def initialize
    @board = []
    @feedback_row = ["-", "-", "-", "-"]
    @colors = {'r' => :red, 'g' => :green, 'y' => :yellow,
               'c' => :cyan, 'm' => :magenta, 'b' => :black
              }
  end

  def add_to_board(guess_row, feedback)
    board << guess_row << feedback
  end

  def return_guess_row(guess)
    guess.chars.map { |letter| '■'.colorize(colors[letter]) }    
  end

  # def colors
  #   [:red, :green, :yellow, :cyan, :magenta, :black].each { |color| puts '■'.colorize(color) }
  # end

  def display
    board.each_slice(2) { |row| puts "%s %s %s %s | %s %s %s %s" % row.flatten }
  end

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

  def main_game
    loop do
      puts "type red, green, yellow, cyan magenta, black"
      answer = gets.chomp
      guess = board.return_guess_row(answer)
      board.add_to_board(guess, ["t", "t", "t", "t"])
      board.display
    end
  end

end

Game.new.main_game
# current_board = Board.new
# guess = current_board.return_guess_row("rbym")
# current_board.add_to_board(guess, ["t", "t", "t", "t"])
# guess = current_board.return_guess_row("mbgy")
# current_board.add_to_board(guess, ["x", "x", "x", "x"])
# current_board.display
