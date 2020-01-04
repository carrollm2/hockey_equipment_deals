require_relative '../../config/environment'
require_relative '../hockey_equipment_deals'

class HockeyEquipmentDeals::TopSeller

  include HockeyEquipmentDeals::InstanceMethods

  attr_accessor :name, :sales_price, :description_link, :store

  @@all = []

  def initialize(hockey_deal_hash)
    @name = self.set_name(hockey_deal_hash)
    @sales_price = hockey_deal_hash[:sales_price]
    @description_link = self.set_description_link(hockey_deal_hash)    
    @store = self.set_store(hockey_deal_hash[:store])

    @@all << self
  end

  def self.create_from_collection(hockey_deal_array)
    hockey_deal_array.each_with_index do |hockey_deal, index|
      new_hockey_deal = HockeyEquipmentDeals::TopSeller.new(hockey_deal_array[index])
    end
  end  

  def self.all
    @@all
  end  
  
  def self.get_top_seller_hockey_deal(selection_criteria)
    if selection_criteria == 'top sellers'
      HockeyEquipmentDeals::TopSeller.all
    elsif selection_criteria == 'top sellers under $75'
      HockeyEquipmentDeals::TopSeller.all.select {|equipment| equipment.sales_price.gsub("$","").strip.to_i < 75.00}
    end
  end  

  def print_message
    puts "This #{@name} is a top seller available to you at #{@sales_price}. Check here, #{@description_link}, for more details"
  end


end
