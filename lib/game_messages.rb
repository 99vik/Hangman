module GameMessages
    def welcome_msg
      puts "Welcome to the Hangman game!".bold
      puts "Computer will randomly select a word for you to guess.".bold
      puts "Press ENTER to start.".bold
      gets
    end

    def letter_included_msg(letter)
      puts " #{letter.upcase} is included!".green
    end

    def letter_not_included_msg(letter)
      puts " #{letter.upcase} is not included!".red
    end

    def game_won_msg
      puts "\nCongratulations, you won the game!".green
      print "The word was: "
    end

    def enter_letter_msg
      print "\nEnter choosen letter:"
    end

    def letter_already_entered_msg
      puts "\nLetter already entered, please choose different one."
    end

    def incorrect_letter_input_msg
      puts "\nIncorrect input.".red
      puts "Please enter 1 letter.".red
    end
  end
  
  # Modify messages for colour, boldnes etc.
  class String
      def red
        "\e[31m#{self}\e[0m"
      end
    
      def green
        "\e[32m#{self}\e[0m"
      end
    
      def blue
        "\e[34m#{self}\e[0m"
      end
    
      def bold
        "\e[1m#{self}\e[22m"
      end
    end