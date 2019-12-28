require_relative '../config/environment'

class CommandLineInterface
  BASE_PATH = "https://www.icewarehouse.com/"

  def run

    self.make_top_seller_hockey_deal
    self.make_clearance_hockey_deal

    site_menu = Menu.new

    #initalize main_menu_respons (y/n) as y

    show_main_menu_response = "y"

    while show_main_menu_response.downcase == "y"
      
      site_menu.display_main_menu

      deal_option_chosen = site_menu.get_response

      if deal_option_chosen == 1

        run_top_seller_menu(site_menu)
      
      elsif deal_option_chosen == 2

        run_top_seller_menu_under_75(site_menu)

      elsif deal_option_chosen == 3

        run_clearance_menu(site_menu)     

      elsif deal_option_chosen == 4

        run_clearance_menu_under_75(site_menu)    

      elsif deal_option_chosen == 5

        show_main_menu_response = "n"

      else

        site_menu.display_selection_not_found
        
      end

      if deal_option_chosen != 5
        site_menu.ask_user_to_go_back_to_main_menu
        show_main_menu_response = gets.strip.to_s.downcase
      end

    end
  end


  def run_top_seller_menu(menu)

    menu.display_top_seller_message

    self.display_top_seller_hockey_deal

    menu.ask_which_top_seller_to_select

    selected_top_seller = menu.get_response

    self.print_selected_hockey_deal(selected_top_seller, 'top sellers')

  end

  def run_top_seller_menu_under_75(menu)

    menu.display_top_seller_message

    self.display_top_seller_hockey_deal_under_75

    menu.ask_which_top_seller_to_select

    selected_top_seller = menu.get_response

    self.print_selected_hockey_deal(selected_top_seller, 'top seller under $75')

  end

  def run_clearance_menu(menu)

    menu.display_clearance_message

    self.display_clearance_hockey_deal

    menu.ask_which_clearance_item_to_select

    selected_clearance_item = menu.get_response

    self.print_selected_hockey_deal(selected_clearance_item, 'clearance')

  end

  def run_clearance_menu_under_75(menu)

    menu.display_clearance_message

    self.display_clearance_hockey_deal_under_75

    menu.ask_which_clearance_item_to_select

    selected_clearance_item = menu.get_response

    self.print_selected_hockey_deal(selected_clearance_item, 'clearance under $75')

  end
  

  def make_top_seller_hockey_deal
    equipment_array = Scraper.scrape_top_seller(BASE_PATH)
    HockeyEquipmentDeals::TopSeller.create_from_collection(equipment_array)
  end

  def make_clearance_hockey_deal
    equipment_array = Scraper.scrape_clearance(BASE_PATH)
    HockeyEquipmentDeals::Clearance.create_from_collection(equipment_array)
  end

  def get_deal_option_chosen(chosen_description)

    if chosen_description == 'top sellers'
      chosen_description_items = get_top_seller_hockey_deal
    elsif chosen_description == 'top seller under $75'
      chosen_description_items = get_top_seller_hockey_deal_under_75
    elsif chosen_description == 'clearance'
      chosen_description_items = get_clearance_hockey_deal
    elsif chosen_description == 'clearance under $75'
      chosen_description_items = get_clearance_hockey_deal_under_75
    end
    chosen_description_items
  end



  def display_top_seller_hockey_deal
    HockeyEquipmentDeals::TopSeller.all.each_with_index do |equipment, index|
      puts "#{index + 1}\t#{equipment.name.upcase}"
      puts "\tprice:" + " #{equipment.sales_price}"
      puts "\tdescription link:" + " #{equipment.description_link}\n\n"
    end
  end

  def get_top_seller_hockey_deal
    all_top_sellers = HockeyEquipmentDeals::TopSeller.all
    all_top_sellers
  end


  def display_top_seller_hockey_deal_under_75
    under_75 = HockeyEquipmentDeals::TopSeller.all.select {|equipment| equipment.sales_price.gsub("$","").strip.to_i < 75.00}

    under_75.each_with_index do |equipment, index|
      puts "#{index + 1}\t#{equipment.name.upcase}"
      puts "\tprice:" + " #{equipment.sales_price}"
      puts "\tdescription link:" + " #{equipment.description_link}\n\n"
    end
  end

  def get_top_seller_hockey_deal_under_75
    under_75 = HockeyEquipmentDeals::TopSeller.all.select {|equipment| equipment.sales_price.gsub("$","").strip.to_i < 75.00}
    under_75
  end


  def display_clearance_hockey_deal
    HockeyEquipmentDeals::Clearance.all.each_with_index do |equipment, index|
      puts "#{index + 1}\t#{equipment.name.upcase}"
      puts "\tprice:" + " #{equipment.clearance_price}"
      puts "\tdescription link:" + " #{equipment.description_link}\n\n"
    end
  end

  def get_clearance_hockey_deal
    all_clearance = HockeyEquipmentDeals::Clearance.all
    all_clearance
  end


  def display_clearance_hockey_deal_under_75
    under_75 = HockeyEquipmentDeals::Clearance.all.select {|equipment| equipment.clearance_price.gsub("$","").strip.to_i < 75.00}

    under_75.each_with_index do |equipment, index|
      puts "#{index + 1}\t#{equipment.name.upcase}"
      puts "\tprice:" + " #{equipment.clearance_price}"
      puts "\tdescription link:" + " #{equipment.description_link}\n\n"
    end
  end

  def get_clearance_hockey_deal_under_75
    under_75 = HockeyEquipmentDeals::Clearance.all.select {|equipment| equipment.clearance_price.gsub("$","").strip.to_i < 75.00}
    under_75
  end

  def print_selected_hockey_deal(selected_item, chosen_description)

    chosen_description_items = get_deal_option_chosen(chosen_description)

    if selected_item.to_i > chosen_description_items.length
      puts "There is no item #{selected_item.to_i} available in menu above."
    else
      chosen_description_items.each_with_index do |equipment, index|
        if index == selected_item.to_i - 1
          selected_equipment = chosen_description_items[index]
          selected_equipment.print_message
        end
      end 
    end
  end

end