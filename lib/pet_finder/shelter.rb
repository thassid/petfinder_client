module PetFinder
  class Shelter
    
    attr_accessor :address1, :address2, :city, :country, :email, :fax, :id, :latitude, :longitude, :name, :phone, :state, :zip
    

    ## Instance Methods
    def initialize(atts={})
      atts.each do |key, value|
        self.send("#{key}=", value) if respond_to?(key)
      end
    end
    
    ## OPTIONS:
    # status  character optional (default=A, public may only list adoptable pets) A=adoptable, H=hold, P=pending, X=adopted/removed
    # offset  integer optional  offset into the result set (default is 0)
    # count integer optional  how many records to return for this particular API call (default is 25)
    # output  string  optional (default=basic)  How much of the pet record to return: id, basic (no description), full
    def get_pets(opts={})
      query = {
        :id => id
      }.merge(opts)
      res = Client.get('/shelter.getPets', :query => query).parsed_response['petfinder']['pets']['pet']
      res.map{|p| Pet.new(p)} unless res.nil? || res.empty?
    end
    
    ## ARGUMENTS:
    # animal  string  required  type of animal (barnyard, bird, cat, dog, horse, pig, reptile, smallfurry)
    # breed string  required  greed of animal(use pet.listBreeds for a list of valid breeds)
    ## OPTIONS: 
    # offset  integer optional  offset into the result set (default is 0)
    # count integer optional  how many records to return for this particular API call (default is 25)
    # format  string  optional (default=xml)  Response format: xml, json
    ## return petfinderShelterRecordList
    def list_by_breed
    end
    
    
    
  end
end