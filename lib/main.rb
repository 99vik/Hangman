require_relative 'game_messages'
require_relative 'display'

class Game
  include GameMessages
  include Display

  def initialize
    welcome_msg
    initialize_variables
    p @secret_word
    until win? || lose? do
      display_board
      display_guessing_word
      gets
    end
  end

  def display_guessing_word
    p @guessing_word.join
  end

  def display_board
    display(@number_of_guesses)
  end
  
  def initialize_variables
    @secret_word = select_random_word
    @guessing_word = Array.new(@secret_word.length, " _ ")
    @number_of_guesses = 0
  end

  def select_random_word
    random_word = ''
    until random_word.length.between?(5, 12) do
      File.open('google-10000-english-no-swears.txt') do |file|
        file_lines = file.readlines()
        random_word = file_lines[Random.rand(0...file_lines.size())].strip
      end
    end
    random_word.split('')
  end

  def win?

  end

  def lose?

  end
end