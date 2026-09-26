require 'app'

RSpec.describe AppCLI do
  it 'runs the CLI' do
    allow_any_instance_of(Object).to receive(:gets).and_return("4")
    expect { AppCLI.run }.to output(/Welcome to TypeNinja!/).to_stdout
  end

  it 'enters typing session' do
    allow_any_instance_of(Object).to receive(:gets).and_return("1", "4")
    expect { AppCLI.run }.to output(/No words in wordbank./).to_stdout
  end

  it 'enters wordbank manager' do
    allow(AppCLI).to receive(:gets).and_return("2", "4")
    allow(WordCLI).to receive(:gets).and_return("6")
    expect { AppCLI.run }.to output(/Welcome to the Wordbank!/).to_stdout
  end

#   it 'enters leaderboard' do
#     allow_any_instance_of(Object).to receive(:gets).and_return("3", "4")
#     expect { AppCLI.run }.to output(/Here are the top scores:/).to_stdout
#   end

  it 'exits the CLI' do
    allow_any_instance_of(Object).to receive(:gets).and_return("4")
    expect { AppCLI.run }.to output(/Exiting TypeNinja. Goodbye!/).to_stdout #raise_error(SystemExit)
  end
end