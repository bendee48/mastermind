module Textable

  def introduction
    puts "Welcome to Mastermind\n"\
         "Enter i for instructions or press return to continue."
         answer = gets.chomp
         instructions if answer == "i"
  end

  def instructions
    puts "Guess the secret four colour code.\n"\
         "You'll need to guess all four colours in their correct positions.\n"\
         "Choose from Red, Green, Yellow, Cyan, Magenta and Black.\n"\
         "Select a colour by using it's first letter eg m = Magenta.\n"\
         "Select 4 colours to make your guess eg. 'rgyb' = Red, Green, Yellow, Black.\n"\
         "After guessing, you'll be shown your guess along with some feedback.\n"\
         "For every correct color in it's correct position you'll be shown a black peg.\n"\
         "For every correct colour not in it's correct position, you'll be shown a white peg.\n"\
         "EXAMPLE\n"\
         "If playing with duplicate colours, a feedback peg will only be shown for every duplicate\n"\
         "colour in the guess, if it corresponds to the same number of duplicates in the code.\n"\
         "EXAMPLE\n"\
         "You have 12 guesses."
  end

end