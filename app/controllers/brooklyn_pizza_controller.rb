	require 'open-uri'

	class BrooklynPizzaController < ApplicationController
	  
	  def index

	    # URL for dynamic content
	    url = "http://www.basketball-reference.com/teams/BRK/2015_games.html"

	    # Open URL using nokogiri
	    doc = Nokogiri::HTML(open(url))
	  	
	  	# W or L from W/L column (8)
	    win_loss_tds = doc.css("#teams_games tbody tr td:nth-child(8):not(:empty)").last
	    @win_loss = win_loss_tds.text
	    # The most recent row
			last_win_loss_row = win_loss_tds.parent

			# Game number from 1st column 
			game_num_col = last_win_loss_row.at("td:first-child")

			# Most recent game number 
			game_num = game_num_col.text.to_i

			# Date from 2nd column
			date_col = last_win_loss_row.at("td:nth-child(2)")

			# Parsed date
			@date = Date.parse(date_col.text)

			@date_sale_end = @date + 1.day 
	  end
	end
