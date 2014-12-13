require 'open-uri'

class RangersController < ApplicationController

  def index

    url = "http://www.hockey-reference.com/teams/NYR/2015_games.html"
    doc = Nokogiri::HTML(open(url))

    win_loss_col_array = doc.css("#games tbody tr td:nth-child(6)").to_a

    # Find most recent game playedin table
    for i in 0 ... win_loss_col_array.size
      if win_loss_col_array[i].blank? # If game postponed
        game_played = i + 3
      elsif (win_loss_col_array[i].text == 'W' || win_loss_col_array[i].text == 'L') && ((win_loss_col_array[i + 1].text) == 'Get Tickets')
        game_played = i + 2
      end
    end
    
    @recent_game_tr = doc.css("#games tbody tr:nth-child(#{game_played})")
    @next_game_tr = doc.css("#games tbody tr:nth-child(#{game_played + 1})")

    for i in 1..9
      case i
      when 1
        @game_number = @recent_game_tr.at_css("td:nth-child(#{i})").text
      when 2
        @date_played = Date.parse(@recent_game_tr.at_css("td:nth-child(#{i})"))
        @next_faceoff = Date.parse(@next_game_tr.at_css("td:nth-child(#{i})"))
        @next_faceoff_formatted = @next_faceoff.strftime("%a. %m/%-d/%Y")
      when 3
        @faceoff_time = @recent_game_tr.at_css("td:nth-child(#{i})").text
        @next_game_time = @next_game_tr.at_css("td:nth-child(#{i})").text
      when 4
        @location = @recent_game_tr.at_css("td:nth-child(#{i})").text
        if @location.empty?
          @location = 'vs.'
        else
          @location = '@'
        end
        @next_location = @next_game_tr.at_css("td:nth-child(#{i})").text
        if @next_location.empty?
          @next_location = 'vs.'
        else
          @next_location = '@'
        end
      when 5
        @recent_opponent = @recent_game_tr.at_css("td:nth-child(#{i})").text
        @next_opponent = @next_game_tr.at_css("td:nth-child(#{i})").text
      when 6
        @result = @recent_game_tr.at_css("td:nth-child(#{i})").text
        if @result == 'W'
          @result = 'Won'
        else
          @result = 'Lost'
        end
      when 7
        @result_variation = @recent_game_tr.at_css("td:nth-child(#{i})").text
      when 8
        @rangers = @recent_game_tr.at_css("td:nth-child(#{i})").text
      when 9
        @opponent = @recent_game_tr.at_css("td:nth-child(#{i})").text
      end
    end         
  end
end