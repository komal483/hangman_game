#!/bin/bash

# List of words to choose from
words=("linux" "script" "terminal" "bash" "openai" "hangman" "computer" "programming" "developer" "software")

# Select a random word
word=${words[$RANDOM % ${#words[@]}]}
word_length=${#word}
guesses=()
max_attempts=7
attempts=0

# ASCII hangman stages
hangman_stages=(
  "
     ------
     |    |
     |
     |
     |
     |
    _|_
  "
  "
     ------
     |    |
     |    O
     |
     |
     |
    _|_
  "
  "
     ------
     |    |
     |    O
     |    |
     |
     |
    _|_
  "
  "
     ------
     |    |
     |    O
     |   /|
     |
     |
    _|_
  "
  "
     ------
     |    |
     |    O
     |   /|\\
     |
     |
    _|_
  "
  "
     ------
     |    |
     |    O
     |   /|\\
     |   /
     |
    _|_
  "
  "
     ------
     |    |
     |    O
     |   /|\\
     |   / \\
     |
    _|_
  "
)

# Initialize display word with underscores
display_word=$(echo $word | sed 's/./_/g')

# Function to update display word with correct guesses
update_display_word() {
  local letter=$1
  for ((i = 0; i < word_length; i++)); do
    if [[ "${word:$i:1}" == "$letter" ]]; then
      display_word="${display_word:0:i}$letter${display_word:i+1}"
    fi
  done
}

# Main game loop
echo "Welcome to Hangman!"
while [[ "$display_word" != "$word" && $attempts -lt $max_attempts ]]; do
  echo "${hangman_stages[$attempts]}"
  echo "Word: $display_word"
  echo "Guesses: ${guesses[@]}"
  echo "Attempts left: $((max_attempts - attempts))"

  read -p "Guess a letter: " letter

  # Check if letter has already been guessed
  if [[ " ${guesses[@]} " =~ " $letter " ]]; then
    echo "You already guessed '$letter'. Try a different letter."
    continue
  fi

  # Add the letter to guesses
  guesses+=("$letter")

  # Check if the guessed letter is in the word
  if [[ "$word" == *"$letter"* ]]; then
    echo "Good guess!"
    update_display_word "$letter"
  else
    echo "Wrong guess!"
    ((attempts++))
  fi
  echo ""
done

# Check win or lose
if [[ "$display_word" == "$word" ]]; then
  echo "Congratulations! You guessed the word: $word"
else
  echo "${hangman_stages[$attempts]}"
  echo "Game Over! The word was: $word"
fi

