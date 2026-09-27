require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'json'

DB = Sequel.connect('sqlite://api.db')
DB.create_table? :scores do
  primary_key :session_id
  Integer :placement, null: false
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

    def self.update_placements(new_placement, new_cpm)
        # Get all scores from the database
        scores = Score.reverse_order(:cpm).all
        scores.each do |score|
            if score.placement >= new_placement && score.cpm < new_cpm
                score.update(placement: score.placement + 1)
            end
        end
    end
end