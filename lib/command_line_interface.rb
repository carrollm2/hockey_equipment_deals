require_relative 'scraper.rb'
require_relative 'top_seller.rb'
require_relative 'clearance.rb'
require 'nokogiri'

class CommandLineInterface
  BASE_PATH = "https://www.icewarehouse.com/"

  def make_top_seller_hockey_deal
    equipment_array = Scraper.scrape_top_seller(BASE_PATH)
    HockeyEquipmentDeals::TopSeller.create_from_collection(equipment_array)
  end

  def display_top_seller_hockey_deal
    HockeyEquipmentDeals::TopSeller.all.each_with_index do |equipment, index|
      puts "#{index + 1}\t#{equipment.name.upcase}"
      puts "\tprice:" + " #{equipment.sales_price}"
      puts "\tdescription link:" + " #{equipment.description_link}"
      puts "\n\n"
    end
  end

  def print_selected_top_seller_hockey_deal(selected_deal)
    HockeyEquipmentDeals::TopSeller.all.each_with_index do |equipment, index|
      if index == selected_deal.to_i - 1
        puts "Wooooo"
        puts HockeyEquipmentDeals::TopSeller.all[index].name
        puts HockeyEquipmentDeals::TopSeller.all[index].sales_price
        puts HockeyEquipmentDeals::TopSeller.all[index].store

        a = HockeyEquipmentDeals::TopSeller.all[index]
        a.print_message
      end 
    end
  end


  def make_clearance_hockey_deal
    equipment_array = Scraper.scrape_clearance(BASE_PATH)
    HockeyEquipmentDeals::Clearance.create_from_collection(equipment_array)
  end

  def display_clearance_hockey_deal
    HockeyEquipmentDeals::Clearance.all.each_with_index do |equipment, index|
      puts "#{index + 1}\t#{equipment.name.upcase}"
      puts "\tprice:" + " #{equipment.clearance_price}"
      puts "\tdescription link:" + " #{equipment.description_link}"
      puts "\n\n"      
    end
  end

  def print_selected_clearance_hockey_deal(selected_deal)
    # select or detect here -- refactor
    HockeyEquipmentDeals::Clearance.all.each_with_index do |equipment, index|
      if index == selected_deal.to_i - 1
        puts "Wooooo"
        puts HockeyEquipmentDeals::Clearance.all[index].name
        puts HockeyEquipmentDeals::Clearance.all[index].clearance_price
        puts HockeyEquipmentDeals::Clearance.all[index].store

        a = HockeyEquipmentDeals::Clearance.all[index]
        a.print_message
      end 
    end
  end
  
end


