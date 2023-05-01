require 'open-uri'
require 'nokogiri'
require 'csv'
require 'json'

def scrapping

    url = "https://github.com/search?q=Ruby+Web+Scraping"
    items_array = [] # Create an empty array to store the items
    max_pages = 15
    
    for page in 1..max_pages
        puts "Scrapping page #{page}..."
        html = URI.open(url + "&p=#{page}") # Open the url
        doc = Nokogiri::HTML(html) # Parse the html
    
        doc.search('.repo-list li').each do |element|
            name = element.css('a.v-align-middle').text
            description = element.css('p.mb-1').text.strip

            # Object
            item = {
                name: name,
                description: description
            }

            items_array << item
        end

        sleep(10) # Wait 10 seconds before scrapping the next page to avoid being blocked by the server due to exceeding the number of requests per minute as specified in the robots.txt file

        items_array.each_with_index do |item, index|
            puts "-----------------------------------"
            puts "Item #{index + 1} - #{item[:name]}"
            puts "Description: #{item[:description]}"
        end
    end

    

    
end




scrapping