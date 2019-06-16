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
        puts "Thanks."
        loop do
          puts "Computer is guessing..."; sleep(5)
          string_guess = computer_guess(board.current_feedback)
          guess = board.return_row(string_guess)
          feedback = board.return_row(board.return_feedback(guess, code_for_display))
          board.add_to_board(guess, feedback)
          board.display
          (puts "Computer guesses right!"; break) if string_guess == code
          guess_number += 1
          (puts "The computer failed to guess your code :-) Game Over."; break) if guess_number > 11
        end
        break
      end
    end
  
    def computer_guess(colors_to_use)
      colors = ["r", "g", "b", "y", "c", "m"]
      if duplicates
        if colors_to_use.size == 4
          code = ""
          4.times { code << colors_to_use.join[rand(4)] }
          code
        else
          (4 - colors_to_use.size).times { colors_to_use << colors[rand(6)] }
          colors_to_use.join
        end
      else
        if colors_to_use.size == 4
          colors_to_use.sample(4).join
        else
          colors = colors - colors_to_use
          colors_to_use << colors.sample(4 - colors_to_use.size)
          colors_to_use.flatten.join
        end
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