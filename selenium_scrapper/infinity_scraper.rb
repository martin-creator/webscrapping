require 'selenium-webdriver'

options = Selenium::WebDriver::Chrome::Options.new # Create options object to pass to the driver
options.add_argument('--headless')
# Selenium::WebDriver.logger.level = :debug
driver = Selenium::WebDriver.for(:chrome, options: options) # Create driver object and pass options object to it

# Navigate to the page
driver.get "https://www.rottentomatoes.com/browse/movies_in_theaters/"

movies_name_selector = "div.discovery-tiles div[slot=caption] span.p--small"

loop do
    # Get the movies number
    movies_count = driver.find_elements(:css, movies_name_selector).size
    
     begin
        puts "> #{movies_count} movies found so far"
        button = driver.find_element(:css, "div.discovery_actions button")
        button.click
        puts "---Load more button clicked"
        sleep(30)
     rescue Exception => e
        puts "---No more movies to load"
        break
     end
   
end

count = 0
driver.find_elements(:css, movies_name_selector ).each do |e|
    name = e.text

    puts '---------------------------------------------------'
    puts "#{count += 1} - #{name}"
    
    # "" vs '' - "" allows for string interpolation while '' does not
end

# Close the browser
driver.quit
