require 'typing_session'

RSpec.describe TypingSession do
    it 'displays typing session' do
        Word.create(text: "test")
        allow_any_instance_of(Object).to receive(:gets).and_return("\n")
        expect { TypingSession.practice_typing }.to output(/Words:/).to_stdout
    end

    it 'aborts if no words in wordbank' do
        Word.dataset.delete
        expect { TypingSession.practice_typing }.to output(/No words in wordbank./).to_stdout
    end

    it 'displays accuracy, time, and cpm after session' do
        Word.create(text: "test")
        allow_any_instance_of(Object).to receive(:gets).and_return("test")
        expect { TypingSession.practice_typing }.to output(/Your accuracy was 100.0%/).to_stdout
    end

    it 'calculates accuracy' do
        expect( TypingSession.calculate_accuracy("tesp", [Word.new(text: "test")]) ).to be_within(0.0001).of(75.00)
    end

    it 'calculates CPM' do
        expect( TypingSession.calculate_cpm("hello", 2) ).to be_a(Numeric)
    end

    it 'calculates placement' do
        Score.dataset.delete
        Score.create(placement: 1,time: 10, accuracy: 100, cpm: 150)
        Score.create(placement: 2,time: 10, accuracy: 100, cpm: 100)
        expect( TypingSession.calculate_placement(50) ).to eq(3)
    end
end