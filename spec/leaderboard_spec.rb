require 'leaderboard'

RSpec.describe Leaderboard do
    it 'displays the leaderboard' do
        Score.create(placement: 1, time: 10.00, accuracy: 12.34, cpm: 56.78)
        allow_any_instance_of(Object).to receive(:gets).and_return("n")
        expect { Leaderboard.display_leaderboard }.to output(/Here are the top scores:/).to_stdout
    end

    it 'exits the leaderboard if no entries' do
        Score.dataset.delete
        allow_any_instance_of(Object).to receive(:gets).and_return("n")
        expect { Leaderboard.display_leaderboard }.to output(/No scores in leaderboard./).to_stdout
    end
    
    it 'clears the leaderboard' do
        Score.create(placement: 1, time: 10.00, accuracy: 12.34, cpm: 56.78)
        allow_any_instance_of(Object).to receive(:gets).and_return("y")
        expect { Leaderboard.display_leaderboard }.to output(/Leaderboard cleared./).to_stdout
    end

    it 'reorders the placements' do
        Score.dataset.delete
        Score.create(placement: 1,time: 10, accuracy: 100, cpm: 150)
        Score.create(placement: 2,time: 10, accuracy: 100, cpm: 100)
        Score.create(placement: 2,time: 10, accuracy: 100, cpm: 50)
        Score.create(placement: 3,time: 10, accuracy: 100, cpm: 10)
        Leaderboard.update_placements(2, 100)
        expect(Score.where(cpm: 10).first.placement).to eq(4)
    end
end