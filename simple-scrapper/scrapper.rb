require 'open-uri'
require 'nokogiri'
require 'csv'
require 'json'

def scrapping
    html = URI.open('https://github.com/search?q=Ruby+Web+Scraping') # Open the url
    doc = Nokogiri::HTML(html) # Parse the html
    items_array = [] # Create an empty array to store the items

    doc.search('.repo-list li').each do |element|
        name = element.css('a.v-align-middle').text
        description = element.css('p.mb-1').text.strip

        items_array << [name, description]
    end

    # items_array.each_with_index do |item, index|
    #     # puts "-----------------------------------"
    #     # puts "Item #{index + 1} - #{item[0]}"
    #     # puts "Description: #{item[1]}"

        
    # end
    export_csv(items_array)
    export_json(items_array)
end

def export_csv(items_array)
    file_path = "data.csv"
    CSV.open(file_path, 'w') do |csv| # each_with_index does the same as each but it also gives you the index of the item
        csv << ['#', 'Name', 'Description'] # Add headers to the csv file
        items_array.each_with_index do |item, index|
            csv << [ index + 1, item[0], item[1]] # << is the same as .push method and >> is the same as .unshift method in arrays
        end
    end
end

def export_json(items_array)
    file_path = "data.json"
    File.open(file_path, 'w') do |file|
        file.write(JSON.pretty_generate(items_array))
    end
end



scrapping