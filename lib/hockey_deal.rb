require 'pry'

module HockeyDeal

  module InstanceMethods

    def set_name(hockey_deal_hash)
      @name = hockey_deal_hash[:name]
    end

    def set_description_link(hockey_deal_hash)
      @description_link = hockey_deal_hash[:description_link]
    end

    def set_store(store_name)
      @store = store_name
    end
    
  end

end