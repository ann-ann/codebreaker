require 'spec_helper'

module Codebreaker
 describe User do
      let(:user)   { User.new }
    context "#lost_turn" do
      it "decreases turns count" do
        expect {user.lost_turn}.to change{user.turns_counter}.from(10).to(9)
      end
    end

    context "#out_of_turns?" do
      it {expect(user).to_not be_out_of_turns}
      it "returns false if no turns left" do
        10.times {user.lost_turn}
        expect(user).to be_out_of_turns
      end
    end

    context "#decrease_score_by_hint" do
      it "decreases user score" do
        expect{user.decrease_score_by_hint}.to change{user.score}.by(-50)
      end
    end

  end
end