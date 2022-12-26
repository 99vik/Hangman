require_relative 'game_messages'

class Game
  include GameMessages
  attr_reader :secret_word
  
  def initialize
    welcome_msg
    @secret_word = select_random_word
    p @secret_word
    @guessing_word = Array.new(@secret_word.length)
    p @guessing_word
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
end