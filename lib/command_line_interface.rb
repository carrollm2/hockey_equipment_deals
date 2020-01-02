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

        run_top_seller_menu(site_menu, 'top sellers')
      
      elsif deal_option_chosen == 2

        run_top_seller_menu(site_menu, 'top sellers under $75')

      elsif deal_option_chosen == 3

        run_clearance_menu(site_menu, 'clearance')     

      elsif deal_option_chosen == 4

        run_clearance_menu(site_menu, 'clearance under $75')    

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


  def run_top_seller_menu(menu, selection_criteria)

    menu.display_top_seller_message

    display_top_seller_hockey_deal(selection_criteria)

    menu.ask_which_top_seller_to_select

    selected_top_seller = menu.get_response

    print_selected_hockey_deal(selected_top_seller, selection_criteria)

  end


  def run_clearance_menu(menu, selection_criteria)

    menu.display_clearance_message

    display_clearance_hockey_deal(selection_criteria)

    menu.ask_which_clearance_item_to_select

    selected_clearance_item = menu.get_response

    print_selected_hockey_deal(selected_clearance_item, selection_criteria)

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
      chosen_description_items = HockeyEquipmentDeals::TopSeller.get_top_seller_hockey_deal('top sellers')
    elsif chosen_description == 'top sellers under $75'
      chosen_description_items = HockeyEquipmentDeals::TopSeller.get_top_seller_hockey_deal('top sellers under $75')
    elsif chosen_description == 'clearance'
      chosen_description_items = HockeyEquipmentDeals::Clearance.get_clearance_hockey_deal('clearance')
    elsif chosen_description == 'clearance under $75'
      chosen_description_items = HockeyEquipmentDeals::Clearance.get_clearance_hockey_deal('clearance under $75')
    end
    chosen_description_items
  end



  def display_top_seller_hockey_deal(selection_criteria)
    
    if selection_criteria == 'top sellers'
      equipment_array = HockeyEquipmentDeals::TopSeller.get_top_seller_hockey_deal('top sellers')
    elsif selection_criteria == 'top sellers under $75'
      equipment_array = HockeyEquipmentDeals::TopSeller.get_top_seller_hockey_deal('top sellers under $75')
    end
    
    equipment_array.each_with_index do |equipment, index|
      puts "#{index + 1}\t#{equipment.name.upcase}"
      puts "\tprice:" + " #{equipment.sales_price}"
      puts "\tdescription link:" + " #{equipment.description_link}\n\n"
    end      

  end


  def display_clearance_hockey_deal(selection_criteria)
    
    if selection_criteria == 'clearance'
      equipment_array = HockeyEquipmentDeals::Clearance.get_clearance_hockey_deal('clearance')
    elsif selection_criteria == 'clearance under $75'
      equipment_array = HockeyEquipmentDeals::Clearance.get_clearance_hockey_deal('clearance under $75')
    end    
    
    equipment_array.each_with_index do |equipment, index|
      puts "#{index + 1}\t#{equipment.name.upcase}"
      puts "\tprice:" + " #{equipment.clearance_price}"
      puts "\tdescription link:" + " #{equipment.description_link}\n\n"
    end
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