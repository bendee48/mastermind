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

# class Player

#   def initialize
#     @score = 0
#   end

# end

class Computer
end

class Game
include Textable

  attr_accessor :board, :code, :duplicates

  def initialize
    @board = Board.new
    @code 
    @duplicates = false
  end

  def code_for_display
    board.return_row(code)
  end

  def game_start
    introduction
    set_duplicates
    select_game_loop
  end

  def select_game_loop
    loop do
      puts "Select game mode. Enter (1) to guess a code or (2) to set the code."
      answer = gets.chomp
      if answer == "1"
        guess_game_loop
        break
      elsif answer == "2"
        comp_game_loop
        break
      else
        puts "I did not recognise that request."
      end
    end
  end

  def set_duplicates
    puts "Would you like to play with duplicates? Enter 'y' or 'n'."
    answer = gets.chomp.downcase
    if answer == 'y'  
      puts "Thanks. Duplicates allowed."
      self.duplicates = true
    elsif answer == 'n'
      puts "Thanks. No duplicates allowed."
    else
      puts "I'll take that as a no. No duplicates allowed." 
    end
  end

  def set_code
    if duplicates
      code = ""
      4.times { code << "rgcmyb"[rand(6)] }
      self.code = code
    else
      self.code = %w(r g y c m b).to_a.sample(4).join
    end
  end

  def guess_game_loop
    guess_number = 0
    set_code

    loop do
      puts "Make your selection (r)ed, (g)reen, (y)ellow, (c)yan, (m)agenta, (b)lack."
      answer = gets.chomp.downcase
      (puts "That's an incorrect selection."; redo) if !sequence_validated?(answer)
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

  def comp_game_loop
    guess_number = 0

    loop do
      puts "Set your 4 colour code, (r)ed, (g)reen, (y)ellow, (c)yan, (m)agenta, (b)lack."
      answer = gets.chomp.downcase
      (puts "Invalid code selection."; redo) if !sequence_validated?(answer)
      (puts "Duplicates are set to false. Select again."; redo) if !sequence_duplicate_validated?(answer)
      self.code = answer
      p code
      puts "Thanks."
      loop do
        puts "Computer is guessing..."; sleep(2)
        guess = board.return_row(computer_guess)
        feedback = board.return_row(board.return_feedback(guess, code_for_display))
        board.add_to_board(guess, feedback)
        board.display
        (puts "Computer guesses right!"; break) if guess == code
        guess_number += 1
        (puts "The computer failed to guess your code :-) Game Over."; break) if guess_number > 11
      end
      break
    end
  end

  def computer_guess
    if duplicates
      code = ""
      4.times { code << "rgcmyb"[rand(6)] }
      code
    else
      %w(r g y c m b).to_a.sample(4).join
    end
  end

  private

  def sequence_validated?(guess)
    guess.match?(/[rgycmb]{4}/) && guess.size == 4
  end

  def sequence_duplicate_validated?(code)
    (duplicates == false && duplicates_present?(code)) ? false : true
  end

  def duplicates_present?(code)
    code.chars.uniq != code.chars
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
