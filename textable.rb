module Textable

  def introduction
    puts "Welcome to Mastermind."; sleep 2
    puts "Enter i for instructions or press Return to continue."
    answer = gets.chomp
    instructions if answer == "i"
  end

  def instructions
    puts "Guess the secret four colour code or set a four colour code for the computer to guess."; sleep 3
    puts "To win, all four colours in their correct positions need to be guessed."; sleep 3
    puts "Choose from Red, Green, Yellow, Cyan, Magenta and Black."; sleep 3
    puts "Select a colour by using it's first letter eg. m = Magenta."; sleep 3
    puts "Select 4 colours to make a guess eg. 'rgyb' = Red, Green, Yellow, Black."; sleep 3
    puts "After guessing, the guess along with feedback will be shown."; sleep 3
    puts "For every correct color within it's correct position, a black peg will be given."; sleep 5
    puts "For every correct colour 'not' within it's correct position, a white peg will be given."; sleep 5
    puts "Example: A code of 'rgyb' and a guess of 'rymc' would return 1 black peg and 1 white peg."; sleep 5
    puts "If playing with duplicate colours, a feedback peg will be shown for every duplicate"; sleep 3
    puts "colour in the guess 'only' if it corresponds to the same number of duplicates in the code."; sleep 5
    puts "Example: A code of 'rrgg' and a guess of 'rrrg' would return 3 black pegs and 0 whites as feedback."; sleep 3
    puts "There will be 12 attempts to guess the code."
  end

end