require 'sinatra';
require 'open-uri';
require 'nokogiri';
require 'json';

get '/' do
    'Hello Martin Joseph Lubowa'
end

get '/repos' do
    html = URI.open('https://github.com/search?q=Ruby+Web+Scraping') # Open the url
    doc = Nokogiri::HTML(html) # Parse the html
    items_array = [] # Create an empty array to store the items

    doc.search('.repo-list li').each do |element|
        name = element.css('a.v-align-middle').text
        description = element.css('p.mb-1').text.strip

        repo = {
            name: name,
            description: description
        }

        items_array << repo
    end

    JSON.pretty_generate(items_array)
end

