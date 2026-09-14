require 'app'

RSpec.describe Word do
  it 'creates a word' do
    expect(Word.create(text: "test")) == Word.get("test")
  end
end

RSpec.describe Word do
  it 'updates a word' do
    word = Word.create(text: "test")
    expect(word.update(text: "updated")) == Word.get("updated")
  end
end

RSpec.describe Word do
  it 'deletes a word' do
    word = Word.create(text: "test")
    expect(word.delete) == true
  end
end