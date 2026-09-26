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
            accuracy = calculate_accuracy(user_input, words)
            cpm = calculate_cpm(user_input, b - a)
            # Create a placement calculation to determine the placement
            puts "That took you #{b - a} seconds"
            puts "Your accuracy was #{accuracy}% and your CPM was #{cpm}."
            Score.create(time: b - a, accuracy: accuracy, cpm: cpm)
        end
    end

    def self.calculate_accuracy(user_input, words)
        correct_chars = 0
        sentence = words.map(&:text).join(" ")
        total_chars = sentence.length
        user_input.chars.each_with_index do |char, index|
            correct_chars += 1 if char == sentence[index]
        end
        accuracy = (correct_chars.to_f / total_chars) * 100
        accuracy.round(2)
    end

    def self.calculate_cpm(user_input, time_taken)
        cpm = (user_input.length.to_f / time_taken) * 60
        cpm.round(2)
    end
end