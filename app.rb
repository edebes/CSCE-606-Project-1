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

get '/words' do
    words = Word.all
    json words
end

post '/words' do
    data = JSON.parse(request.body.read)
    word = Word.create(text: data['text'])
    json word
end

get '/words/:id' do
    word = Word[params[:id]]
    halt 404, json({ error: 'Word not found' }) unless word
    json word
end

put '/words/:id' do |id|
    word = Word[params[:id]]
    halt 404, json({ error: 'Word not found' }) unless word
    data = JSON.parse(request.body.read)
    word.update(text: data['text'])
    json word
end

delete '/words/:id' do |id|
    word = Word[params[:id]]
    halt 404, json({ error: 'Word not found' }) unless word
    word.delete
    json word
end