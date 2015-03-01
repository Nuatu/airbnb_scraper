require 'open-uri'
require 'nokogiri'
require 'csv'

# URL to be scraped
url = "https://www.airbnb.com/s/Brooklyn--NY--United-States"

# Nokogiri to parse/save page
page = Nokogiri::HTML(open(url))

# Store data in arrays
names = []
page.css('div.h5.listing-name').each do |line|
  names << line.text
end

prices = []
page.css('span.h3.price-amount').each do |line|
  prices << line.text
end

details = []
page.css('div.text-muted.listing-location.text-truncate').each do |line|
  details << line.text
end

# Write data to CSV file
CSV.open("airbnb_listings.csv", "w") do |file|
  file << ["Listing Name", "Price", "Details"]
  
  names.length.times do |i|
    file << [names[i], prices[i], details[i]]
  end
end