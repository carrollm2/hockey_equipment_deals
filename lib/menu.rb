require_relative 'scraper.rb'
require_relative 'top_seller.rb'
require_relative 'clearance.rb'
require 'nokogiri'


class Menu

  def display_main_menu
    puts "Which type of hockey equipment deal are you searching for?"
    puts "Choose number below:"
    puts "(1) top sellers"
    puts "(2) top sellers under $75"  
    puts "(3) clearance" 
    puts "(4) clearance under $75"      
    puts "(5) exit"
  end

  def get_response
    gets.to_i
  end

  def ask_user_to_go_back_to_main_menu
    puts "\nWould you like to go back to main menu (y/n)"
  end


  def display_selection_not_found
    puts "Selection not found"
  end

  def display_top_seller_message
    puts "Please see the Top Sellers below.\n"
  end

  def ask_which_top_seller_to_select
    puts "\nWhich top seller would you like to select?"
  end  

   def display_clearance_message
    puts "Please see the Clearance items below.\n"
  end

  def ask_which_clearance_item_to_select
    puts "\nWhich clearance item would you like to select?"
  end  
  
end