require 'leaderboard'

RSpec.describe Leaderboard do
    it 'displays the leaderboard' do
        allow_any_instance_of(Object).to receive(:gets).and_return("n")
        expect { Leaderboard.display_leaderboard }.to output(/No scores in leaderboard./).to_stdout
    end
    
    it 'clears the leaderboard' do
        Score.create(time: Time.now, accuracy: 90, cpm: 200)
        allow_any_instance_of(Object).to receive(:gets).and_return("y")
        expect { Leaderboard.display_leaderboard }.to output(/Leaderboard cleared./).to_stdout
    end
end