require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'json'
require_relative 'leaderboard'

class TypingSession
    def self.practice_typing
        words = Word.all
        if words.empty?
            puts "\nNo words in wordbank."
            return
        end
        puts "\nWords:"
        typing_words = words.shuffle
        typing_words.each { |word|
            print "#{word.text} "
        }
        puts ""
        start_time = Time.new
        begin
            user_input = gets.chomp
        rescue Exception => e
            puts "\nExiting typing session"
        else
            end_time = Time.new
            accuracy = calculate_accuracy(user_input, typing_words)
            cpm = calculate_cpm(user_input, end_time - start_time)
            placement = calculate_placement(cpm)
            puts "That took you #{end_time - start_time} seconds"
            puts "Your accuracy was #{accuracy}% and your CPM was #{cpm}."
            Score.create(placement: placement,time: end_time - start_time, accuracy: accuracy, cpm: cpm)
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

    def self.calculate_placement(cpm)
        # Get all scores from the database
        scores = Score.reverse_order(:cpm).all

        # Find the placement based on the CPM
        placement = 1
        if scores.empty?
            return placement
        end
        scores.each do |score|
            if cpm > score.cpm
                Leaderboard.update_placements(placement, cpm)
                break
            end
            placement += 1
        end
        placement
    end
end