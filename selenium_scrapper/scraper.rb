require 'selenium-webdriver'

options = Selenium::WebDriver::Chrome::Options.new # Create options object to pass to the driver
options.add_argument('--headless')
# Selenium::WebDriver.logger.level = :debug
driver = Selenium::WebDriver.for(:chrome, options: options) # Create driver object and pass options object to it

# Navigate to the page
driver.get "https://github.com/search?q=Ruby+Web+Scraping"


driver.find_elements(:css, ".repo-list li").each do |e|
    name = e.find_element(:css, "a.v-align-middle ").text
    description = e.find_element(:css, "p.mb-1").text.strip

    puts '---------------------------------------------------'
    puts "#{name}"
    puts "#{description}"

    # "" vs '' - "" allows for string interpolation while '' does not
end

# Close the browser
driver.quit
