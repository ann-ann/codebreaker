
module Codebreaker
 class User
    attr_accessor :username, :turns_counter

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

    def score
      @score + @turns_counter * 100
    end

    def decrease_score_by_hint
      @score -= 50
    end
  end
end