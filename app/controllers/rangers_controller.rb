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
        most_recent_game_row = i + 2
      elsif (win_loss_col[i].text == 'W' || win_loss_col[i].text == 'L') && ((win_loss_col[i + 1].text) == 'Get Tickets')
        most_recent_game_row = i + 1
      end
    end
    
    # Determine the most recent result (win or lose)
    @most_recent_result = doc.css("#games tbody tr:nth-child(#{most_recent_game_row + 1}) td:nth-child(6)").text

    if @most_recent_result == 'W'
      @result = 'The Rangers won!'
    else
      @result = 'The Rangers lost!'
    end
  end

end