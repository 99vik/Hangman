module GameMessages
    def welcome_msg
      puts "Welcome to the Hangman game!".bold
      puts "Computer will randomly select a word for you to guess.".bold
      puts "Press ENTER to start.".bold
      gets
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