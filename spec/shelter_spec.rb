require 'spec_helper'


describe "PetFinder::Shelter" do
  
  context "shelter pets" do
    use_vcr_cassette
    it "should return a list of pets that belong to a given shelter" do
      shelter = one_shelter
      # note: we need to instansiate the client here to make this unit test pass - yucky.  cost of having the 
      #       shelter classes dependent on the client class.  maybe this method should be moved to the the client class ?
      client = PetFinder::Client.new('fake')
      pets = shelter.get_pets({:count => 2})
      pets.map{|p| p.id}.should == two_shelter_pets.map{|p| p.id}
    end
  end
  
end