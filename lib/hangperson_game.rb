class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize word
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

  
  def guess guess_string
      if guess_string.nil? or guess_string.length < 1 or not guess_string =~ /[[:alpha:]]/
        raise ArgumentError
      end
      
      temp_guess = guess_string.downcase
      
      if guess_string.length > 1 or @guesses.include? temp_guess or @wrong_guesses.include? temp_guess
          return false
      end
      
      if @word.downcase.include? temp_guess
          @guesses  << guess_string
      else 
        @wrong_guesses << guess_string
      end
  end
  
  def word_with_guesses
    ret_str = ''
    @word.chars do |cur_char|
        if @guesses.include? cur_char
            ret_str << cur_char
        else
            ret_str << '-'
        end
     end
     if ret_str.empty?
         puts "ret str empty"
     end
     return ret_str
  end
    
 # def check_win_or_lose
  #  @word.subset?(@guesses)
   #  
  #end
end
def guess_several_letters(game, letters)
  letters.chars do |letter|
      game.guess(letter)
    end
end

game = HangpersonGame.new('banana')
guess_several_letters(game, "ban")
puts game.word_with_guesses



