require 'open-uri'
require 'nokogiri'

def scrapping
    html = URI.open('https://github.com/search?q=Ruby+Web+Scraping') # Open the url
    doc = Nokogiri::HTML(html) # Parse the html

    puts doc

end

scrapping