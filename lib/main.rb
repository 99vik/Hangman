require_relative 'game_messages'
require_relative 'display'

class Game
  include GameMessages
  include Display

  def initialize
    welcome_msg
    @play_again = true
    until @play_again == false
      start_game
    end
  end
  
  def start_game
    random_word_and_start_msg
    initialize_variables
    p @secret_word
    until win? || lose? do
      display_board
      display_entered_letters
      display_guessing_word
      guess_a_letter(input_a_letter)
    end
    if win?
      game_won
    else
      game_lost
    end
    play_again
  end

  def play_again
    play_again_msg
    play_again_input
  end

  def play_again_input
    input = gets.strip.downcase
    if input == "y"
       @play_again = true
    elsif input == "n"
      @play_again = false
    else
      wrong_play_again_input_msg
      play_again
    end
  end

  def game_lost
    display_board
    game_lost_msg
    puts @secret_word.join('').capitalize
  end

  def game_won
    game_won_msg
    puts @secret_word.join('').capitalize
  end

  def guess_a_letter(letter)
    if @secret_word.include?(letter)
      letter_included_msg(letter)
      push_letter_on_guess_array(letter)
    else
      letter_not_included_msg(letter)
       @number_of_guesses += 1
    end
  end

  def push_letter_on_guess_array(letter)
    all_indexes_in_sw_with_letter(letter).each { |index| @guessing_word[index] = " #{letter} " }
  end

  def all_indexes_in_sw_with_letter(letter)
    @secret_word.each_index.select { |index| @secret_word[index] == letter }
  end

  def input_a_letter
    enter_letter_msg
    letter = gets.strip.downcase
    if letter.length != 1 || !('a'..'z').to_a.include?(letter)
      incorrect_letter_input_msg
      input_a_letter
    elsif @entered_letters.include?(letter)
      letter_already_entered_msg
      input_a_letter
    else
      @entered_letters.push(letter)
      letter
    end
  end

  def display_entered_letters
    print "\nPreviously entered letters:   "
    puts @entered_letters.join(' , ') 
  end

  def display_guessing_word
    print "\nSecret word:   "
    puts @guessing_word.join
  end

  def display_board
    display(@number_of_guesses)
  end
  
  def initialize_variables
    @secret_word = select_random_word
    @guessing_word = Array.new(@secret_word.length, " _ ")
    @number_of_guesses = 0
    @entered_letters = []
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
    !@guessing_word.include?(' _ ')
  end

  def lose?
    @number_of_guesses == 6
  end
end