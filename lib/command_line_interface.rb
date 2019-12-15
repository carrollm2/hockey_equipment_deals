require_relative 'scraper.rb'
require_relative 'top_seller.rb'
require_relative 'clearance.rb'
require 'nokogiri'

class CommandLineInterface
  BASE_PATH = "https://www.icewarehouse.com/"

  def make_top_seller_hockey_deal
    equipment_array = Scraper.scrape_top_seller(BASE_PATH)
    HockeyDeal::TopSeller.create_from_collection(equipment_array)
  end

  def display_top_seller_hockey_deal
    HockeyDeal::TopSeller.all.each_with_index do |equipment, index|
      puts "#{index + 1}\t#{equipment.name.upcase}"
      puts "\tprice:" + " #{equipment.sales_price}"
      puts "\tdescription link:" + " #{equipment.description_link}"
      puts "\n\n"
    end
  end

  def print_selected_top_seller_hockey_deal(selected_deal)
    HockeyDeal::TopSeller.all.each_with_index do |equipment, index|
      if index == selected_deal.to_i - 1
        puts "Wooooo"
        puts HockeyDeal::TopSeller.all[index].name
        puts HockeyDeal::TopSeller.all[index].sales_price
        puts HockeyDeal::TopSeller.all[index].store

        a = HockeyDeal::TopSeller.all[index]
        a.print_message
      end 
    end
  end


  def make_clearance_hockey_deal
    equipment_array = Scraper.scrape_clearance(BASE_PATH)
    HockeyDeal::Clearance.create_from_collection(equipment_array)
  end

  def display_clearance_hockey_deal
    HockeyDeal::Clearance.all.each_with_index do |equipment, index|
      puts "#{index + 1}\t#{equipment.name.upcase}"
      puts "\tprice:" + " #{equipment.clearance_price}"
      puts "\tdescription link:" + " #{equipment.description_link}"
      puts "\n\n"      
    end
  end

  def print_selected_clearance_hockey_deal(selected_deal)
    # select or detect here -- refactor
    HockeyDeal::Clearance.all.each_with_index do |equipment, index|
      if index == selected_deal.to_i - 1
        puts "Wooooo"
        puts HockeyDeal::Clearance.all[index].name
        puts HockeyDeal::Clearance.all[index].clearance_price
        puts HockeyDeal::Clearance.all[index].store

        a = HockeyDeal::Clearance.all[index]
        a.print_message
      end 
    end
  end
  
end


