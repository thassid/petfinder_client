require 'spec_helper'

# NOTE: you need a valid Pet Finder API Key.  Use the PF_API_KEY environment variable.
# Example: LIVE_PF_API=acbd1234 rspec live_pf_api_spec.rb


# TODO: This spec will test the live API - just in case PetFinder changes it's API format.  It should not be run as a normal part of the test suite.
if ENV['LIVE_PF_API']

  describe "Live testing of the Pet Finder API" do
  
    it "should return a valid client with a valid key" do
      pending "should we test the client upon initialization for a valid API key ?"
    end
  
  end

end