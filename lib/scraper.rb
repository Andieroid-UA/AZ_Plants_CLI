require 'nokogiri'
require 'open-uri'

require_relative 'plant'

class Scraper
  def self.extract_plant_names(doc)
    plants = doc.css('h4[style="padding-bottom:0px;"]')
    scientific_names = doc.css('p[style="margin-top:0px;padding-top:0px;"] i')

    plants.map.with_index do |plant_element, index|
      plant_name = plant_element.text.strip
      scientific_name = scientific_names[index].text.strip if scientific_names[index]

      Plant.new(plant_name, scientific_name)
    end
  end

  def self.scrape_data(url)
    page_string = URI.open(url, &:read)
    doc = Nokogiri::HTML(page_string)
    extract_plant_names(doc)
  end
end
