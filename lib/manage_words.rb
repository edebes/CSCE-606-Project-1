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

class WordCLI
    def self.manage_words
        puts "\nWelcome to the Wordbank!"
        loop do
            puts "1. List all words"
            puts "2. Add a word"
            puts "3. Update a word"
            puts "4. Delete a word"
            puts "5. Delete all words"
            puts "6. Go Back\n"
            choice = gets.chomp.to_i
            case choice
            when 1
                self.list_words
            when 2
                self.add_word
            when 3
                self.update_word
            when 4
                self.delete_word
            when 5
                self.delete_all_words
            when 6
                #go back to above menu
                puts "\nReturning to typing menu\n\n"
                break
            else
                puts "Invalid option. Please try again."
            end
        end  
    end
    
    def self.list_words
        words = Word.all
        if words.empty?
            puts "\nNo words in wordbank."
        else
            puts "\nWords:"
            words.each { |word|
                puts "#{word.text}"
            }
        end
    end

    def self.add_word
        puts "\nEnter new word:"
        text = gets.chomp
        if text[/\A[a-zA-Z]+\z/] != text
            puts "\nInvalid word. Please enter a word with only letters."
            return
        end
        word = Word.create(text: text)
        puts "\nWord added: #{word.text}"
    end

    def self.update_word
        if Word.count == 0
            puts "\nNo words in wordbank to update."
            return
        end
        puts "\nEnter the word to update:"
        old_text = gets.chomp
        word = Word.find(text: old_text)
        if word
            puts "\nEnter the updated word:"
            new_text = gets.chomp
            word.update(text: new_text)
            puts "\nWord updated from #{old_text} to #{new_text}"
        else
            puts "\nWord not found."
        end
    end

    def self.delete_word
        if Word.count == 0
            puts "\nNo words in wordbank to delete."
            return
        end
        puts "\nEnter the word to delete:"
        text = gets.chomp
        word = Word.find(text: text)
        if word
            word.delete
            puts "\nWord deleted: #{word.text}"
        else
            puts "\nWord not found."
        end
    end

    def self.delete_all_words
        if Word.count == 0
            puts "\nNo words in wordbank to delete."
            return
        end
        puts "\nAre you sure you want to delete all words? (y/n)"
        ans = gets.chomp.downcase
        if ans == 'y'
            Word.dataset.delete
            puts "\nAll words deleted."
        end
    end
end

