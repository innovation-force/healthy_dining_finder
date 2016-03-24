module HDF
 require_relative 'healthy_dining_finder/version.rb'
 require 'net/http'
 require 'json'
 require 'logger'

  BASE_URL = ENV["HDF_BASE_URL"]
  TOKEN =  ENV["HDF_TOKEN"]

  @@logger = Logger.new STDOUT
  @@logger.level = Logger::WARN

  def self.read_json(json_file)
      json_response(File.read(json_file))
  end

  def self.all_clients
      target_url = URI("#{BASE_URL}AllClientJSON.svc/client/#{TOKEN}")
      result = Net::HTTP.get_response(target_url)
      if result.code == '200'
        clients = JSON.parse(result.body)
        clients["GetAllClientJSONResult"]["clientList"]
      else
        @@logger.info(result.message)
        false
      end
  end

  def self.client_info(client_code)
      target_url = URI("#{BASE_URL}GetClientJSON.svc/Client/#{TOKEN}/#{client_code}")
      result = Net::HTTP.get_response(target_url)
      if result.code == '200'
          info = JSON.parse(result.body)
          info["getClientJSONResult"]["clientList"].first
      else
          @@logger.info(result.message)
          false
      end
  end

  def self.client_dishes_all_details(client_code)
      target_url = URI("#{BASE_URL}ClientDishesAllDetailsJSON.svc/Client/#{TOKEN}/#{client_code}")
      result = Net::HTTP.get_response(target_url)
      if result.code == '200'
        dishes = JSON.parse(result.body)
        dishes["clientDishesAllDetailsJSONResult"]["RestaurantItemDetails"]
      else
        @@logger.info(result.message)
        false
      end
  end

  def self.client_dishes_all_details_by_radius(address, radius)
      address_encoded = URI.encode(address)
      target_url = URI("#{BASE_URL}ClientDishesAllDetailsByAddressRadiusJSON.svc/dish/#{TOKEN}/#{address_encoded}/#{radius}")
      result = Net::HTTP.get_response(target_url)
        if result.code == '200'
          dishes = JSON.parse(result.body)
          dishes["clientDishesAllDetailsByAddressAndRadiusJSONResult"]["RestaurantMenuItemList"]
        else
          @@logger.info(result.message)
          false
        end
  end

  def self.restaurants_by_location(address)
      address_encoded = URI.encode(address)
      target_url = URI("#{BASE_URL}RestaurantLocationsByZipCodeCityStateJSON.svc/RESTAURANT/#{TOKEN}/allrestaurants/#{address_encoded}/6")
      result = Net::HTTP.get_response(target_url)
        if result.code == '200'
          restaurants = JSON.parse(result.body)
          restaurants["restaurantLocationsByZipCodeCityStateJSONResult"]["LocationNCSRestaurant"]
        else
          @@logger.info(result.message)
          false
        end
  end

  def self.dishes_by_sodium(address, keyword, sodium, radius)
      address_encoded = URI.encode(address)
      target_url = URI("#{BASE_URL}/DishesBySodiumbyAddressRadiusJSON.svc/dish/sodium/#{TOKEN}/#{address_encoded}/#{keyword}/#{sodium}/#{radius}")
      result = Net::HTTP.get_response(target_url)
        if result.code == '200'
          dishes = JSON.parse(result.body)
          dishes["dishesBySodiumbyAddressRadiusJSONResult"]["RestaurantMenuItemList"]
        else
          @@logger.info(result.message)
          false
        end
  end

end
