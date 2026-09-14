require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'json'

DB = Sequel.connect('sqlite://api.db')
DB.create_table? :words do
  primary_key :id
  String :text, null: false
end

class Word < Sequel::Model(:words)
    plugin :json_serializer
end

# get words
get '/words' do
    Word.map(:text).join("\n") + "\n"
end

# create new words
post '/words' do
    data = JSON.parse(request.body.read)
    word = Word.create(text: data['text'])
    "Word created: #{word.text}" + "\n"
end

# get a specific word
get '/words/:id' do
    word = Word[params[:id]]
    halt 404, json({ error: 'Word not found' }) unless word
    "#{word.text}" + "\n"
end

# update a specific word
put '/words/:id' do |id|
    word = Word[params[:id]]
    oldWord = word.text
    halt 404, json({ error: 'Word not found' }) unless word
    data = JSON.parse(request.body.read)
    word.update(text: data['text'])
    "Word updated from #{oldWord} to #{word.text}" + "\n"
end

# delete a specific word
delete '/words/:id' do |id|
    word = Word[params[:id]]
    halt 404, json({ error: 'Word not found' }) unless word
    word.delete
    "Word deleted: #{word.text}" + "\n"
end

# clear all words
delete '/words' do
    Word.dataset.delete
    "All words deleted" + "\n"
end