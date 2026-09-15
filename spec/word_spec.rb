require 'app'

RSpec.describe Word do
  it 'creates a word' do
    word = Word.create(text: "testOne")
    expect(word).to be_valid
  end

  it 'updates a word' do
    word = Word.create(text: "testTwo")
    word.update(text: "updated")
    expect(word.reload.text).to eq("updated")
  end

  it 'deletes a word' do
    word = Word.create(text: "testThree")
    oldCount = Word.count
    word.delete
    expect(Word.count).to eq(oldCount - 1)
  end

  it 'shows all words' do
    Word.create(text: "testFour")
    Word.create(text: "testFive")
    expect(Word.map(:text)).to include("testFour", "testFive")
  end

  it 'deletes all words' do
    Word.create(text: "testSix")
    Word.create(text: "testSeven")
    Word.dataset.delete
    expect(Word.count).to eq(0)
  end

  it 'runs the CLI' do
    allow_any_instance_of(Object).to receive(:gets).and_return("1", "6")
    expect { WordCLI.run }.to output(/Welcome to the Wordbank!/).to_stdout
  end

  it 'lists words in the CLI' do
    Word.create(text: "testEight")
    Word.create(text: "testNine")
    expect { WordCLI.list_words }.to output(/Words:/).to_stdout
  end

  it 'displays empty message when bank is empty' do
    Word.dataset.delete
    expect { WordCLI.list_words }.to output(/No words in wordbank./).to_stdout
  end

  it 'adds a word in the CLI' do
    allow_any_instance_of(Object).to receive(:gets).and_return("testTen")
    expect { WordCLI.add_word }.to output(/Enter new word:/).to_stdout
  end

  it 'updates a word in the CLI' do
    Word.create(text: "testEleven")
    allow_any_instance_of(Object).to receive(:gets).and_return("testEleven")
    expect { WordCLI.update_word }.to output(/Enter the word to update:/).to_stdout
  end

  it 'returns empty message when bank is empty for update' do
    Word.dataset.delete
    expect { WordCLI.update_word }.to output(/No words in wordbank to update./).to_stdout
  end

  it 'lets user enter updated word in the CLI' do
    Word.create(text: "testTwelve")
    allow_any_instance_of(Object).to receive(:gets).and_return("testTwelve", "updatedWord")
    expect { WordCLI.update_word }.to output(/Enter the updated word:/).to_stdout
  end

  it 'returns not found message when word does not exist for update' do
    allow_any_instance_of(Object).to receive(:gets).and_return("nonExistentWord")
    expect { WordCLI.update_word }.to output(/Word not found./).to_stdout
  end

  it 'deletes a word in the CLI' do
    Word.create(text: "testThirteen")
    allow_any_instance_of(Object).to receive(:gets).and_return("testThirteen")
    expect { WordCLI.delete_word }.to output(/Enter the word to delete:/).to_stdout
  end

  it 'returns empty message when bank is empty for delete' do
    Word.dataset.delete
    expect { WordCLI.delete_word }.to output(/No words in wordbank to delete./).to_stdout
  end

  it 'deletes all words in the CLI' do
    Word.create(text: "testFourteen")
    allow_any_instance_of(Object).to receive(:gets).and_return("y")
    expect { WordCLI.delete_all_words }.to output(/Are you sure you want to delete all words\? \(y\/n\)/).to_stdout
  end

  it 'returns empty message when bank is empty for delete all' do
    Word.dataset.delete
    expect { WordCLI.delete_all_words }.to output(/No words in wordbank to delete./).to_stdout
  end

  it 'exits the CLI' do
    allow_any_instance_of(Object).to receive(:gets).and_return("6")
    expect { WordCLI.run }.to output(/Return to typing menu/).to_stdout
  end
end