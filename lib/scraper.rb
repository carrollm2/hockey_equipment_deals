require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_top_seller(index_url)
     # should I make these Class Constants? -- No, because don't want all instances of Class type Scraper to have/use same html
     
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    top_seller_info = []

    top_sell_products = doc.css("div.fp_top_sellers div.fp_prod_cell")

    top_sell_products.each do |product|
      name = product.css("span.fp_prod_name").text
      sales_price = product.css("span.fp_prod_price").text
      description_link = product.css("a")[0]["href"]

      top_seller_bio = {:name => name, :sales_price => sales_price, :description_link => description_link, :store => index_url}
      
      top_seller_info << top_seller_bio
    end
    top_seller_info
   end 

  def self.scrape_clearance(index_url)
     # should I make these Class Constants? -- No, because don't want all instances of Class type Scraper to have/use same html

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    clearance_sale_info = []

    clearance_sale_products = doc.css("div.fp_sale_items div.fp_prod_cell")

    clearance_sale_products.each do |product|
      name = product.css("span.fp_prod_name").text
      clearance_price = product.css("span.fp_prod_price").text
      description_link = product.css("a")[0]["href"]

      clearance_sale_bio = {:name => name, :clearance_price => clearance_price, :description_link => description_link, :store => index_url}
      
      clearance_sale_info << clearance_sale_bio
    end
    clearance_sale_info
   end 
   
end