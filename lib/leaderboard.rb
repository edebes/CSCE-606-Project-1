require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'json'

DB = Sequel.connect('sqlite://api.db')
DB.create_table? :scores do
  primary_key :placement
  Float :time, null: false
  Float :accuracy, null: false
  Float :cpm, null: false
end

class Score < Sequel::Model(:scores)
    plugin :json_serializer
end

class Leaderboard
    def self.display_leaderboard
        scores = Score.order(:placement).all
        if scores.empty?
            puts "\nNo scores in leaderboard."
        else
            puts "\nHere are the top scores:"
            scores.each { |score|
                puts "Placement: #{score.placement}, Time: #{score.time}, Accuracy: #{score.accuracy}, CPM: #{score.cpm}"
            }
            puts "\nWould you like to clear the leaderboard? (y/n)"
            choice = gets.chomp.downcase
            if choice == 'y'
                Score.dataset.delete
                puts "\nLeaderboard cleared."
            else
                puts "\nReturning to main menu."
            end
        end
    end
end