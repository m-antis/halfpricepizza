require 'open-uri'

class RangersController < ApplicationController

  def index

    url = "http://www.hockey-reference.com/teams/NYR/2015_games.html"

    doc = Nokogiri::HTML(open(url))

    last_game_played = doc.css("#games tbody tr td:nth-child(6)").to_a

    for i in 0 ... last_game_played.size
      if (last_game_played[i].text == 'W' || last_game_played[i].text == 'L') && ((last_game_played[i + 1].text) == 'Get Tickets')
        @result = i + 1
      end
      @result
    end

  end

end


