require 'open-uri'
class BrooklynPizzaController < ApplicationController
  def index
    # URL for dynamic content
    url = "http://www.basketball-reference.com/teams/BRK/2015_games.html"
    # Open URL using nokogiri
    doc = Nokogiri::HTML(open(url))
    # Select W/L column
    win_loss_tds = doc.css("#teams_games tbody tr td:nth-child(8):not(:empty)").last
    # Get text from W/L column
    @result = win_loss_tds.text
    # The most recent row
    last_win_loss_row = win_loss_tds.parent
    # Game number from 1st column
    game_num_col = last_win_loss_row.at("td:first-child")
    # Most recent game number
    game_num = game_num_col.text.to_i
    # Date from 2nd column
    date_col = last_win_loss_row.at("td:nth-child(2)")
    # Select last opponent
    @opponent = doc.css("#teams_games tbody tr:nth-child(#{game_num}) td:nth-child(7)").text
    # Get BKLYN score
    @brooklyn = doc.css("#teams_games tbody tr:nth-child(#{game_num}) td:nth-child(10)").text
    # Opponent score
    @opponent_score = doc.css("#teams_games tbody tr:nth-child(#{game_num}) td:nth-child(11)").text
    # Parsed date
    @date = Date.parse(date_col.text)
    # Calculate sale end
    @date_sale_end = @date + 1.day
    #1 Upcoming opponent
    @upcoming_opponent = doc.css("#teams_games tbody tr:nth-child(#{game_num + 1}) td:nth-child(7)").text
    #Next game date
    @next_game = Date.parse(doc.css("#teams_games tbody tr:nth-child(#{game_num + 1}) td:nth-child(2)").text)
    #Next game tip off
    @next_game_tip_off = doc.css("#teams_games tbody tr:nth-child(#{game_num + 1}) td:nth-child(3)").text

    @is_overtime = doc.css("#teams_games tbody tr:nth-child(#{game_num}) td:nth-child(9)").blank?

    if !@is_overtime
      @is_overtime = doc.css("#teams_games tbody tr:nth-child(#{game_num}) td:nth-child(9)").text
    end

    @home_away = doc.css("#teams_games tbody tr:nth-child(#{game_num}) td:nth-child(9)").text

    if @home_away == '@'
      @home_away = 'Away'
    else
      @home_away = 'Home'
    end

    @date_sale_end.strftime("%B %d, %Y")
    @next_game.strftime("%B %d, %Y")
  end
end
