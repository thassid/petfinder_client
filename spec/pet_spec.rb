require 'spec_helper'

describe "PetFinder::Pet" do
  
  it "should be able to extract a hash of photo urls from it's data" do
    pet = full_pet_objs[0]
    pet.get_photos.should == pet_photos_hash
  end
  
end