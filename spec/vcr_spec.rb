require 'spec_helper'
RSpec.describe "VCR", :vcr do
    it "manages the Net::HTTP get requests" do
      response = Net::HTTP.get_response(URI('http://www.iana.org/domains/reserved'))
      expect(response.body).to include("Example domains")
    end
  end
