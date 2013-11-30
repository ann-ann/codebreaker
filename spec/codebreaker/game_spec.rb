require 'spec_helper'
 
module Codebreaker
  describe Game do

    let(:output) { double('output').as_null_object }
    let(:game)   { Game.new(output) }
    before {game.start('1234') }

    # Code-breaker starts game 
    describe "#start" do
      it "sends a welcome message" do
        expect(output).to receive(:puts).with('Welcome to Codebreaker!')
        game.start
      end
      
      it "ask to enter username" do
        expect(output).to receive(:puts).with('Please enter username: ')
        expect(output).to receive(:gets)
        game.start
      end

      it "generates a secret code" do
        game.start()
        expect(game.code).to_not be_nil
      end

      it "prompts for the first guess" do
        expect(output).to receive(:puts).with('Enter guess:')
        game.start()
      end
    end

    # Code-breaker submits guess
    describe "#guess" do
       
      it "increase number of times user tried to guess" do
         expect{ game.guess('1111') }.to change{ game.user.turns_counter }.by(1)
      end

      context "no matches" do
        it "sends no signs" do 
          expect(output).to receive(:puts).with('') 
          game.guess('5555')
        end 
      end
      
      context "1 num match" do
        it "sends - sign" do
          expect(output).to receive(:puts).with('-')
          game.guess('9871')
        end
      end
      
      context "1 exact match" do
        it "sends + sign" do
          expect(output).to receive(:puts).with('+')
          game.guess('1678')
        end
      end

      context "2 exact matchs and 2 num matches" do
        it "sends ++-- signs" do
          expect(output).to receive(:puts).with('++--')
          game.guess('1243')
        end
      end

      context "all num matches" do
        it "sends ---- signs" do
          expect(output).to receive(:puts).with('----')
          game.guess('4321')
        end
      end

      context "all exact matches" do
        it "sends message about user won" do
          expect(output).to receive(:puts).with('++++')
          game.guess('1234')
        end
      end
    end
    # Code-breaker requests hint
    describe "#hint" do
      
      context "first hint where no nums guessed" do
        it "shows first num and 'x' signs for hidden nums" do
          game.guess_result = ''
          expect(output).to receive(:puts).with("1xxx")
          game.hint
        end
      end
      
      context "second hint where no nums guessed" do
        it "shows first and second nums" do
          game.guess_result = ''
          game.hint_value = "1"
          expect(output).to receive(:puts).with("12xx")
          game.hint
        end
      end
    end

    # Code-breaker wins game, Code-breaker loses game
    describe "#proccess_output" do
      
      context "user win if alll nums opened (marked as +)" do
        it "shows message 'You win!!'" do
          game.guess_result = '++++'
          expect(output).to receive(:puts).with("You win!!")
          game.proccess_output
        end
      end

      context "user losses if there was more than 20 turns" do
        it "shows messahe 'Sorry, you lost this game'" do
          game.user.turns_counter = 20
          expect(output).to receive(:puts).with('Sorry, you lost this game')
          game.proccess_output
        end
      end

      context "user continue game" do
        it "shows some posotive motivation message" do
          expect(output).to receive(:puts).with('Go on!')
          game.proccess_output
        end
      end
    end

    # Code-breaker plays again
    describe "#promt_game" do
      
      it "ask user about new game" do
        expect(output).to receive(:puts).with('Wanna play again?')
        game.promt_game
      end

      it "returns user answer" do
        output.stub(:gets).and_return("y")
        expect(game.promt_game).to eql("y")
        game.promt_game
      end
    end
    # Code-breaker saves score
    describe "#save_score" do
      
      it "ask user to save information about game" do
        expect(output).to receive(:puts).with('Wanna save your score ?')
        game.save_score
      end

      it "saves info about game if user want" do
        file = double('file')
        output.stub(:gets).and_return("y")
        expect(File).to receive(:open).with("scores.csv", "w").and_yield(file)
        expect(file).to receive(:write).with(game.user)
        game.save_score
      end
    end
  end
end