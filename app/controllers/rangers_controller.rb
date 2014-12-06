require 'open-uri'

class RangersController < ApplicationController

  def index

    url = "http://www.hockey-reference.com/teams/NYR/2015_games.html"
    doc = Nokogiri::HTML(open(url))

    # Array of all game results (won or lost)
    win_loss_col = doc.css("#games tbody tr td:nth-child(6)").to_a

    # Find most recent game in table by searching array 'win_loss_col'
    for i in 0 ... win_loss_col.size
      if win_loss_col[i].blank? # If game postponed
        game_played = i + 3
      elsif (win_loss_col[i].text == 'W' || win_loss_col[i].text == 'L') && ((win_loss_col[i + 1].text) == 'Get Tickets')
        game_played = i + 2
      end
    end
    
    # Determine the most recent result ('W' or 'L')
    @result = doc.css("#games tbody tr:nth-child(#{game_played}) td:nth-child(6)").text

    @opponent_name = doc.css("#games tbody tr:nth-child(#{game_played}) td:nth-child(5)").text

    @rangers = doc.css("#games tbody tr:nth-child(#{game_played}) td:nth-child(8)").text

    @opponent = doc.css("#games tbody tr:nth-child(#{game_played}) td:nth-child(9)").text

    @date = Date.parse(doc.css("#games tbody tr:nth-child(#{game_played + 1}) td:nth-child(2)").text)

    @next_opponent = doc.css("#games tbody tr:nth-child(#{game_played + 1}) td:nth-child(5)").text

    @time = doc.css("#games tbody tr:nth-child(#{game_played + 1}) td:nth-child(3)").text




  end
end