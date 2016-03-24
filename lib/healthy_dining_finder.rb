require_relative 'healthy_dining_finder/version.rb'

   module HDF
   require 'net/http'
   require 'json'

   BASE_URL = ENV["HDF_BASE_URL"] 
   TOKEN =  ENV["HDF_TOKEN"] 

  def self.read_json(json_file)
      json_response(File.read(json_file))
  end

  def self.all_clients
      #Returns an array of hashes including all clients (restaurants) available from HDF
      target_url = URI("#{BASE_URL}AllClientJSON.svc/client/#{TOKEN}")
      result = json_response Net::HTTP.get(target_url)
      clients = result["GetAllClientJSONResult"]["clientList"]
  end

  def self.client_info(client_code)
      #GetClientJSON - Gets a list of all dishes and data for a particular client.
      target_url = URI("#{BASE_URL}GetClientJSON.svc/Client/#{TOKEN}/#{client_code}")
      result = json_response Net::HTTP.get(target_url)
      info = result["getClientJSONResult"]["clientList"].first
  end

  def self.client_dishes_all_details(client_code)
      #ClientDishesAllDetailsJSON - This shows all client dish information for a particular client.
      target_url = URI("#{BASE_URL}ClientDishesAllDetailsJSON.svc/Client/#{TOKEN}/#{client_code}")
      result = json_response Net::HTTP.get(target_url)
      dishes = result["clientDishesAllDetailsJSONResult"]["RestaurantItemDetails"]
  end

  def self.client_dishes_all_details_by_radius(address, radius)
      #ClientDishesAllDetailsByAddressRadius - This shows all dishes available at a particular location.
      address_encoded = URI.encode(address)
      target_url = URI("#{BASE_URL}ClientDishesAllDetailsByAddressRadiusJSON.svc/dish/#{TOKEN}/#{address_encoded}/#{radius}")
      result = json_response Net::HTTP.get(target_url)
      dishes = result["clientDishesAllDetailsByAddressAndRadiusJSONResult"]["RestaurantMenuItemList"]
  end

  def self.restaurants_by_location(address)
        address_encoded = URI.encode(address)
        target_url = URI("#{BASE_URL}RestaurantLocationsByZipCodeCityStateJSON.svc/RESTAURANT/#{TOKEN}/allrestaurants/#{address_encoded}/6")
        result = Net::HTTP.get_response(target_url)
        if result.code == '200'
        restaurants = JSON.parse(result.body)
        restaurants["restaurantLocationsByZipCodeCityStateJSONResult"]["LocationNCSRestaurant"]
        else
          return false
        end
  end
    
  def self.dishes_by_sodium(address, keyword, sodium, radius)
      #DishesBySodiumbyAddressRadiusJSON - Unique service to search by location and sodium value for dish. Sodium numbers tend to be in the 500 plus range.
      address_encoded = URI.encode(address)
      target_url = URI("#{BASE_URL}/DishesBySodiumbyAddressRadiusJSON.svc/dish/sodium/#{TOKEN}/#{address_encoded}/#{keyword}/#{sodium}/#{radius}")
      result = json_response Net::HTTP.get(target_url)
      if result
        dishes = result["dishesBySodiumbyAddressRadiusJSONResult"]["RestaurantMenuItemList"]
      else
          return false
      end
  end

  private

  def self.json_response(response)
      JSON.parse(response)
      rescue JSON::ParserError
      #Log the error, raise it, send a message.
  end

  def self.parse_all_dishes_for_client(json_response)
      result = json_response['clientDishesAllDetailsJSONResult']['RestaurantItemDetails'] #An Array of hashes
      details.map {|h| puts h["dish_name"] }
  end

end