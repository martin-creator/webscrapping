require 'open-uri'
require 'nokogiri'

def scrapping
    html = URI.open('https://github.com/search?q=Ruby+Web+Scraping') # Open the url
    doc = Nokogiri::HTML(html) # Parse the html
    items_array = [] # Create an empty array to store the items

    doc.search('.repo-list li').each do |element|
        name = element.css('a.v-align-middle').text
        description = element.css('p.mb-1').text.strip

        items_array << [name, description]
    end

    items_array.each_with_index do |item, index|
        puts "-----------------------------------"
        puts "Item #{index + 1} - #{item[0]}"
        puts "Description: #{item[1]}"
    end

end

scrapping