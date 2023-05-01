require 'open-uri'
require 'nokogiri'
require 'csv'
require 'json'

def scrapping

    url = "https://github.com/search?q=Ruby+Web+Scraping"
    items_array = [] # Create an empty array to store the items
   

    html = URI.open(url) # Open the url
    doc = Nokogiri::HTML(html) # Parse the html

    total_results = doc.css('div .d-flex.flex-column.flex-md-row.flex-justify-between.border-bottom.pb-3.position-relative h3').text.split(" ")[0].to_i
    

    results_per_page = 10
    max_pages = (total_results / results_per_page.to_f).floor + 1


    
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

def scrapping_with_pagination
    url = "https://github.com/search?q=Ruby+Web+Scraping"
    items_array = [] # Create an empty array to store the items
    page = 1
    next_page = true

    while next_page
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

        # check if there is a disabled next page button somewhere in the page
        disabled_next_button = doc.search('span.next_page.disabled')

        if disabled_next_button.any?
            next_page = false #  stop loop from running again
        else 
            page += 1 # increment page number
        end

        sleep(10) # Wait 10 seconds before scrapping the next page to avoid being blocked by the server due to exceeding the number of requests per minute as specified in the robots.txt file

        items_array.each_with_index do |item, index|
            puts "-----------------------------------"
            puts "Item #{index + 1} - #{item[:name]}"
            puts "Description: #{item[:description]}"
        end

    end
end




# scrapping
scrapping_with_pagination