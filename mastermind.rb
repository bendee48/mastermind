require 'colorize'

class Board
  attr_accessor :board, :guess_row, :feedback_row, :colors

  def initialize
    @board = []
    @guess_row = ["-", "-", "-", "-"]
    @feedback_row = ["-", "-", "-", "-"]
    @colors = {'r' => :red, 'g' => :green, 'y' => :yellow,
               'c' => :cyan, 'm' => :magenta, 'b' => :black
              }
  end

  def add_to_board(guess, feedback)
    board << [guess, feedback]
  end

  def add_to_guess_row(guess)
    guesses = guess.chars.map { |letter| '■'.colorize(colors[letter]) }    
    guess_row.replace(guesses)
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

  def initialize
    @board = Board.new
  end

  def main_game
    puts "type red, green, yellow, cyan magenta, black"
    answer = gets.chomp
    add_to_guess_row(answer)
    add_to_board
  end

end

Board.new.add_to_guess_row("rgyc")