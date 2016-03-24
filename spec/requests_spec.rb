require 'spec_helper'
RSpec.describe "HDF Requests", :vcr do
    
    it "Gets a list of all clients" do 
        req = HDF.all_clients
        expect(req[0].keys).to include("client_name")
    end
    
    it "Given a valid client code it gets info for a restaurant" do 
        req = HDF.client_info("chilis")
        expect(req.keys).to include("client_name")
    end
    
    it "Given a valid client code it returns all dishes for a restaurant" do
        req = HDF.client_dishes_all_details("redlobster")
        expect(req[0].keys).to include("dish_name")
    end
    
    it "Given a valid address and radius it returns all dishes" do 
        req = HDF.client_dishes_all_details_by_radius("200 SW Market Street, Portland, OR", 3)
        expect(req[0].keys).to include("dish_name")
    end
    

    it "Given a valid address it returns restaurants within a 6 mile radius" do 
        req = HDF.restaurants_by_location("200 SW Market Street, Portland, OR")
        expect(req).to be_an(Array)
    end
    
    it "Given a valid address, keyword, sodium count and radius it returns a menu list" do 
        req = HDF.dishes_by_sodium("97201", "chicken", "500", "8")
        expect(req).to be_an(Array)
    end
    
end