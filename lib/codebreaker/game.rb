require 'scanf'

module Codebreaker
  class Game
    
    attr_accessor :code, :guess_result, :hint_value, :user
    
    def initialize(output)
      @output = output
      @hint_value = ''
      @user = User.new
    end

    def start
      @code = Random.rand(1111..6666)
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Please enter username: '
      @user.username = @output.gets
      @output.puts 'Enter guess:'
    end
    
    def guess(guess)
      @guess_result = ''
      (0..3).each do |i|
        @guess_result << ((guess[i] == @code[i])? "+" : "-")  if @code.include? guess[i]
      end
      @user.lost_turn
      @guess_result
    end
    
    def hint
      tmp = ''
      (0..hint_value.size).each { |i| tmp << code[i] } 
      hint_value = tmp
      (code.size - hint_value.size).times {tmp << 'x'}
      @output.puts(tmp)
    end

    def proccess_output
      if @guess_result == '++++'
        @output.puts('You win!!')
      elsif @user.out_of_turns?
          @output.puts('Sorry, you lost this game')
        else
          @output.puts('Close enough :) Try again!')
      end
    end

    def promt_game
      @output.puts('Wanna play again?')
      answer = @output.gets
      answer
    end

    def save_score
      @output.puts('Wanna save your score ?')
      answer = @output.gets
      if(answer.eql? 'y') 
        File.open "scores.csv", "w" do |file| 
          file.write(user) 
        end
      end       
    end
  end

  class User
    attr_accessor :username, :score, :turns_counter

    def initialize(username = 'no_name')
      @username = username
      @score = 0
      @turns_counter = 10
    end

    def to_s
      @username + " " + @score + " " + @turns_counter
    end

    def lost_turn
      @turns_counter -= 1
    end

    def out_of_turns?
      true if @turns_counter <= 0
    end

  end
end
# TODO scoring


