class Board
  attr_accessor :board, :colors, :current_feedback

  def initialize
    @board = []
    @colors = {'r' => :red, 'g' => :green, 'y' => :yellow,
               'c' => :cyan, 'm' => :magenta, 'b' => :black,
               'w' => :white
              }
    @current_feedback = []
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
    current_feedback.clear

    guess.each.with_index do |guess_item, ind|
      if guess_item == code[ind]
        black += 1
        current_feedback << feedback_colors_hash[guess_item]
      else
        code.each.with_index do |code_item, ind|
          if code_item == guess_item && (code_item != guess[ind] && !used.include?(code_item))
            white += 1
            used << code_item
            current_feedback << feedback_colors_hash[guess_item]
          end
        end
      end
    end
    feedback_to_string([black, white])
  end

  def feedback_colors_hash
    colors_hash = {}
    colors.each { |k, v| colors_hash['■'.colorize(v)] = k }
    colors_hash
  end

  def display
    board.each_slice(2) { |row| puts " %s %s %s %s | %s %s %s %s" % row.flatten }
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

end