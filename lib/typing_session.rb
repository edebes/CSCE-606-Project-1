require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'json'

class TypingSession
    def self.practice_typing
        words = Word.all
        if words.empty?
            puts "\nNo words in wordbank."
            return
        else
            puts "\nWords:"
            words.each { |word|
                print "#{word.text} "
            }
            puts ""
        end
        a = Time.new
        begin
            user_input = gets.chomp
        rescue Exception => e
            puts "\nExiting typing session"
        else
            b = Time.new
            puts "That took you #{b - a} seconds"
        end
    end
end