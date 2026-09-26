require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'json'
require_relative 'leaderboard'
require_relative 'typing_session.rb'
require_relative 'manage_words.rb'

class AppCLI
    def self.run
        puts "\nWelcome to TypeNinja!"
        loop do
            puts "\nPlease select an option:"
            puts "1. Do a typing session"
            puts "2. Manage Words"
            puts "3. Leaderboard"
            puts "4. Exit\n"
            choice = gets.chomp.to_i
            case choice
            when 1
                TypingSession.practice_typing
            when 2
                # go to database menu to manage words
                WordCLI.manage_words
            when 3
                #leaderboard call
            when 4
                puts "\nExiting TypeNinja. Goodbye!"
                break #exit(0)
            else
                puts "Invalid option. Please try again."
            end
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    AppCLI.run
    exit(0)
end