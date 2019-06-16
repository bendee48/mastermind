The Odin Project

Ruby - Object Orientated Programming

Project 2: Mastermind

- Create a command line Mastermind game in Ruby.
- Game mode 1 allows the player to guess a random generated code.
- Game mode 2 allows the player to set a code for the computer to guess (basic AI).
- Computer AI will incorporate previous colours it knows were in the code (from the feedback) in future guesses.
- Code can be set to include duplicates or not.

Rules
  - Guess the secret four colour code or set a four colour code for the computer to guess.
  - To win, all four colours in their correct positions need to be guessed.
  - Choose from Red, Green, Yellow, Cyan, Magenta and Black.
  - Select a colour by using it's first letter eg. m = Magenta.
  - Select 4 colours to make a guess eg. 'rgyb' = Red, Green, Yellow, Black.
  - After guessing, the guess along with feedback will be shown.
  - For every correct colour within it's correct position, a black peg will be given.
  - For every correct colour 'not' within it's correct position, a white peg will be given.
  - Example: A code of 'rgyb' and a guess of 'rymc' would return 1 black peg and 1 white peg.
  - If playing with duplicate colours, a feedback peg will be shown for every duplicate,
    colour in the guess 'only' if it corresponds to the same number of duplicates in the code.
  - Example: A code of 'rrgg' and a guess of 'rrrg' would return 3 black pegs and 0 whites as feedback.
  - There will be 12 attempts to guess the code.