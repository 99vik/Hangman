# frozen_string_literal: true

require_relative 'game_messages'
require_relative 'display'
require 'erb'
require 'json'

class Game
  include GameMessages
  include Display

  def initialize
    welcome_msg
    @play_again = true
    start_game until @play_again == false
  end

  def start_game
    load_or_new_game
    p @secret_word
    until win? || lose?
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

  def new_game
    initialize_variables
  end

  def load_game
    show_shaved_games
    choose_save_to_load
  end

  def show_shaved_games
    print "\nSaved games: "
    saved_file_names = Dir.entries('saved_games').select { |name| name.include?('.json') }
    puts saved_file_names.map { |name| name.delete_suffix('.json') }.join(' , ')
  end

  def choose_save_to_load
    print "\nChoose name of a file to load:"
    name = gets.strip
    choosen_save = JSON.parse File.open("saved_games/#{name}.json", 'r')
    load_values_from_save(choosen_save)
  end

  def load_values_from_save(save_values)
    @guessing_word = save_values['guessing_word']
    @number_of_guesses = save_values['number_of_guesses']
    @secret_word = save_values['secret_word']
    @entered_letters = save_values['entered_letters']
  end

  def load_or_new_game
    game_instructions_msg
    input = gets.strip.downcase
    if input == 'load'
      load_game
    else
      new_game
    end
  end

  def play_again
    play_again_msg
    play_again_input
  end

  def play_again_input
    input = gets.strip.downcase
    case input
    when 'y'
      @play_again = true
    when 'n'
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

  def save_game
    choose_save_name_msg
    choose_save_name
  end

  def choose_save_name
    save_name = gets.strip
    save_file(save_name)
  end

  def save_file(name)
    file = File.open("./saved_games/#{name}.json", 'w')
  rescue Exception => e
    puts "ERROR: #{e}"
    puts 'Please choose a different file name.'
    save_game
  else
    erb_template = ERB.new File.read('save_template.erb')
    form_letter = erb_template.result(binding)
    file.write(form_letter)
    file.close
    save_game_msg
  end

  def input_a_letter
    enter_letter_msg
    letter = gets.strip.downcase
    if letter == 'save'
      save_game
      exit
    end
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
    @guessing_word = Array.new(@secret_word.length, ' _ ')
    @number_of_guesses = 0
    @entered_letters = []
  end

  def select_random_word
    random_word = ''
    until random_word.length.between?(5, 12)
      File.open('google-10000-english-no-swears.txt') do |file|
        file_lines = file.readlines
        random_word = file_lines[Random.rand(0...file_lines.size)].strip
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
