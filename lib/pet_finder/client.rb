module PetFinder
  
  class InvalidClientError < StandardError
  end
  
  class Client
    
    include HTTParty
    base_uri 'http://api.petfinder.com/'
    format :xml
    
    # TODO: make this a singleton class
    def initialize(key)
      Client.default_params({:key => key})
    end
        
    ## ARGUMENTS:
    #  location string  required  the ZIP/postal code or city and state where the search should begin
    ## OPTIONS:
    #  name string  optional if location is specified full or partial shelter name
    #  offset integer optional  offset into the result set (default is 0)
    #  count  integer optional  how many records to return for this particular API call (default is 25)
    def find_shelters(location, opts={})
      query = {
        :location => location
      }.merge(opts)
      res = Client.get('/shelter.find', :query => query).parsed_response['petfinder']['shelters']['shelter']
      res = [res] unless res.is_a?(Array)
      res.map{|atts| Shelter.new(atts)} unless res.nil? || res.empty?
    end
    
  
    def get_shelter(shelter_id, opts={})
      query = {
        :id => shelter_id
      }.merge(opts)
      res = Client.get('/shelter.get', :query => query).parsed_response['petfinder']['shelter']
      Shelter.new(res) unless res.nil?
    end
    
    ## breed.list
    ## ARGUMENTS:
    # animal	string	required	type of animal (barnyard, bird, cat, dog, horse, pig, reptile, smallfurry)
    def list_breeds(animal)
      query = {:animal => animal}
      res = Client.get('/breed.list', :query => query).parsed_response['petfinder']['breeds']['breed']
    end
    
    
    ## ARGUMENTS:
    # location  string  required  the ZIP/postal code or city and state where the search should begin
    ## OPTIONS:
    # animal	string	optional	type of animal (barnyard, bird, cat, dog, horse, pig, reptile, smallfurry)
    # breed string  optional  breed of animal (use pet.listBreeds for a list of valid breeds)
    # size  string  optional  size of animal (S=small, M=medium, L=large, XL=extra-large)
    # sex character optional  M=male, F=female
    # age string  optional  age of the animal (Baby, Young, Adult, Senior)
    # offset  string  optional  set this to the value of lastOffset returned by a previous call to pet.find, and it will retrieve the next result set
    # count integer optional  how many records to return for this particular API call (default is 25)
    # output  string  optional (default=basic)  How much of each record to return: basic (no description) or full (includes description)
    def find_pets(location, opts={})
      query = {
        :location => location
      }.merge(opts)
      res = Client.get('/pet.find', :query => query).parsed_response['petfinder']['pets']['pet']
      res = [res] unless res.is_a?(Array)
      res.map{|p| Pet.new(p)} unless res.nil? || res.empty?
    end
    
    
    ## NOTE:  Recieving 500 error from PF API.  Not a very useful request anyways.
    # ## ARGUMENTS:
    # # animal  string  required  type of animal (barnyard, bird, cat, dog, horse, pig, reptile, smallfurry)
    # # breed string  required  greed of animal(use pet.listBreeds for a list of valid breeds)
    # ## OPTIONS: 
    # # offset  integer optional  offset into the result set (default is 0)
    # # count integer optional  how many records to return for this particular API call (default is 25)
    # def list_shelters_with_breed(animal, breed, opts={})
    #   query = {
    #     :animal => animal,
    #     :breed => breed
    #   }.merge(opts)
    #   res = Client.get('/shelter.listByBreed', :query => query).parsed_response['petfinder']['shelters']['shelter']
    # end
  
    
    def get_pet(pet_id, opts={})
      query = {
        :id => pet_id
      }.merge(opts)
      res = Client.get('/pet.get', :query => query).parsed_response['petfinder']['pet']
      Pet.new(res) unless res.nil?
    end
    
    
    ## NOTE: Not very useful ???    
    # ## OPTIONS:
    # # animal  string  optional  type of animal (barnyard, bird, cat, dog, horse, pig, reptile, smallfurry)
    # # breed string  optional  breed of animal (use breeds.list for a list of valid breeds)
    # # size  string  optional  size of animal (S=small, M=medium, L=large, XL=extra-large)
    # # sex character optional  M=male, F=female
    # # location  string  optional  the ZIP/postal code or city and state the animal should be located (NOTE: the closest possible animal will be selected)
    # # shelterid string  optional  ID of the shelter that posted the pet
    # # output  string  optional (default=id) How much of the pet record to return: id, basic, full
    # def get_random_pet(opts={})
    #   res = Client.get('/pet.getRandom', :query => opts)
    #   Pet.new(res) unless res.nil?
    # end
    
    
    
  
  end
end 


