require 'selenium-webdriver'

options = Selenium::WebDriver::Chrome::Options.new # Create options object to pass to the driver
options.add_argument('--headless')
# Selenium::WebDriver.logger.level = :debug
driver = Selenium::WebDriver.for(:chrome, options: options) # Create driver object and pass options object to it

# Navigate to the page
driver.get "https://metaruby.com/"

item_names_selector = "a.title.raw-link.raw-topic-link"

current_total = driver.find_elements(:css, item_names_selector).size

 loop do
    driver.execute_script("window.scrollTo(0, 10000)") # The advantage of using the window body height is that it will always scroll to the bottom of the page
    sleep(5)

    new_total = driver.find_elements(:css, item_names_selector).size
    
    if new_total == current_total
        puts "---No more items to load"
        break
    else
        current_total = new_total
        puts "> #{current_total} items found so far"
    end

 end

count = 0
driver.find_elements(:css, item_names_selector).each do |e|
    name = e.text

    puts '---------------------------------------------------'
    puts "#{count += 1} - #{name}"

    # "" vs '' - "" allows for string interpolation while '' does not
end

# Close the browser
driver.quit
