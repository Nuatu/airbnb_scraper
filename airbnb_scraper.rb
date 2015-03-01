require 'open-uri'
require 'nokogiri'
require 'csv'

# URL to be scraped
url = "https://www.airbnb.com/s/Brooklyn--NY--United-States"

# Nokogiri to parse/save page
page = Nokogiri::HTML(open(url))

# Scrape max number of pages and store in max_page variable
page_numbers = []
page.css("div.pagination ul li a[target]").each do |line|
 page_numbers << line.text
end

max_page = page_numbers.max

puts max_page

# Store data in arrays
names = []
page.css('div.h5.listing-name').each do |line|
  names << line.text.strip
end

prices = []
page.css('span.h3.price-amount').each do |line|
  prices << line.text
end

details = []
page.css('div.text-muted.listing-location.text-truncate').each do |line|
  details << line.text.strip.split(/ · /)
end

# # Write data to CSV file
# CSV.open("airbnb_listings.csv", "w") do |file|
#   file << ["Listing Name", "Price", "Room Type", "Reviews", "Location"]

#   names.length.times do |i|
#     file << [names[i], prices[i], details[i][0], details[i][1], details[i][2]]
#   end
# end