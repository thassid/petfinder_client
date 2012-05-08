require 'spec_helper'

## NOTE: use this as an "integration" test between our different objects

describe "PetFinder::Client" do
  
  before(:each) do
    @client = PetFinder::Client.new('fake')
  end
  
  context "finding list of shelters" do
    use_vcr_cassette
    it "should return a list of shelters given a zipcode or city and state" do
      shelters = @client.find_shelters('92102', {:limit => 2})
      shelters.map{|s| s.id}.should == two_shelters.map{|s| s.id}
    end
  end
  
  context "get single shelter with id" do
    use_vcr_cassette
    it "should find a single shelter given a shelter id" do
      shelter = @client.get_shelter('fake')
      shelter.id.should == one_shelter.id
    end
  end
  
  context "list breeds" do
    use_vcr_cassette
    it "should list breeds given an animal type" do
      breeds = @client.list_breeds('dog').should == dog_breeds_list
    end
  end
  
  context "finding list of pets" do
    use_vcr_cassette
    it "should return a list of pets given a zipcode or city and state" do
      pets = @client.find_pets('San Diego, CA', {:count => 2, :animal => 'dog'})
      pets.map{|p| p.id}.should == two_pets.map{|p| p.id}
    end
  end
  
  # context "find shelters with breed" do
  #   use_vcr_cassette
  #   it "should return a list of shelters with a given animal and breed" do
  #     client = PetFinder::Client.new('afb752054145806e86da4d38721f2bb6')
  #     shelters = client.list_shelters_with_breed('dog', 'collie', {:count => 2})
  #   end
  # end
  
  context "get single pet with id" do
    use_vcr_cassette 
    it "should return a single pet with a given id" do
      pet = @client.get_pet('fake')
      pet.id.should == one_pet.id
    end
  end
  
  
end