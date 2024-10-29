import random

def hangman():
    word_list = ["python", "hangman", "programming", "challenge", "developer"]
    chosen_word = random.choice(word_list)
    guessed_letters = []
    attempts = 6
    display = ["_"] * len(chosen_word)

    hangman_stages = [
        """
           ------
           |    |
           |    O
           |   /|\\
           |   / \\
           |
        """,
        """
           ------
           |    |
           |    O
           |   /|\\
           |   /
           |
        """,
        """
           ------
           |    |
           |    O
           |   /|
           |   
           |
        """,
        """
           ------
           |    |
           |    O
           |    
           |   
           |
        """,
        """
           ------
           |    |
           |    
           |    
           |   
           |
        """,
        """
           ------
           |    
           |    
           |    
           |   
           |
        """,
        """
           
           
           
           
           |   
           |
        """
    ]

    print("Welcome to Hangman!")
    
    while attempts > 0 and "_" in display:
        print(hangman_stages[attempts])
        print("\nWord: " + " ".join(display))
        print(f"Attempts left: {attempts}")
        print("Guessed letters: " + ", ".join(guessed_letters))
        
        guess = input("Guess a letter: ").lower()
        
        if guess in guessed_letters:
            print("You've already guessed that letter. Try again.")
            continue

        guessed_letters.append(guess)

        if guess in chosen_word:
            for index, letter in enumerate(chosen_word):
                if letter == guess:
                    display[index] = guess
            print("Good guess!")
        else:
            attempts -= 1
            print("Incorrect guess!")

    if "_" not in display:
        print("\nCongratulations! You've guessed the word:", chosen_word)
    else:
        print(hangman_stages[0])  # Show the full hangman if game over
        print("\nGame Over! The word was:", chosen_word)

if __name__ == "__main__":
    hangman()
