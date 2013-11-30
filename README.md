# Codebreaker

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'codebreaker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codebreaker

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Game instructions:

Code-breaker starts game\n
The code-breaker opens a shell, types a command, and sees a welcome message and a prompt to enter the first guess.

Code-breaker submits guess
The code-breaker enters a guess, and the system replies by marking the guess according to the marking algorithm.

Code-breaker wins game
The code-breaker enters a guess that matches the secret code exactly. The system responds by marking the guess with four + signs and a message congratulating the code-breaker on breaking the code in however many guesses it took.

Code-breaker loses game
After some number of turns, the game tells the code-breaker that the game is over (need to decide how many turns and whether to reveal the code).

Code-breaker plays again
After the game is won or lost, the system prompts the code-breaker to play again. If the code-breaker indicates yes, a new game begins. If the code-breaker indicates no, the system shuts down.

Code-breaker requests hint
At any time during a game, the code-breaker can request a hint, at which point the system reveals one of the numbers in the secret code.

Code-breaker saves score
After the game is won or lost, the code-breaker can opt to save information about the game: who (initials?), how many turns, and so on.