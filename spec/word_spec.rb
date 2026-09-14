require 'app'

RSpec.describe Word do
  it 'creates a word' do
    expect(Word.create(text: "test")) == Word.get("test")
  end
end