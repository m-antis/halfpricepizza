require 'open-uri'

class BrooklynPizzaController < ApplicationController
  def index

    # URL for dynamic content
    url = "http://www.basketball-reference.com/teams/BRK/2015_games.html"
    
    # Open URL using nokogiri
    doc = Nokogiri::HTML(open(url))
  
    # Scrape data from Web site
    @result = doc.css("#teams_games").xpath("//table/tbody/tr/td[8]/text()")

    # Set date to current
    @date = Date.today

  end
end
