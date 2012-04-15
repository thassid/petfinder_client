module PetFinder
  
  class InvalidClientError < StandardError
  end
  
  class Client
    
    include HTTParty
    base_uri 'http://api.petfinder.com/'
    format :xml
    
    # PF Key: afb752054145806e86da4d38721f2bb6
    # PF Secret: 3700df7d3c49cc7d561e9bcb3e6b4cc0
  
    # Petfinder API Documentation
    # http://www.petfinder.com/developers/api-docs
  
    ## Status Codes
    # 100 PFAPI_OK  No error
    # 200 PFAPI_ERR_INVALID Invalid request
    # 201 PFAPI_ERR_NOENT Record does not exist
    # 202 PFAPI_ERR_LIMIT A limit was exceeded
    # 203 PFAPI_ERR_LOCATION  Invalid geographical location
    # 300 PFAPI_ERR_UNAUTHORIZED  Request is unauthorized
    # 301 PFAPI_ERR_AUTHFAIL  Authentication failure
    # 999 PFAPI_ERR_INTERNAL  Generic internal error
    
    ## For Readme ?
    # NOTE: Petfinder provides a secret for signing requests.  At the time of this writing, there are no API methods that require
    # the secret (or auth token).  There are plans for future methods that will require the secret/auth token.
  
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
      res.map{|p| Pet.new(p)} unless res.nil? || res.empty?
    end
  
    
    def get_pet(pet_id, opts={})
      query = {
        :id => pet_id
      }.merge(opts)
      res = Client.get('/pet.get', :query => query)['petfinder']['pet']
      Pet.new(res) unless res.nil?
    end
    
        
    ## OPTIONS:
    # animal  string  optional  type of animal (barnyard, bird, cat, dog, horse, pig, reptile, smallfurry)
    # breed string  optional  breed of animal (use breeds.list for a list of valid breeds)
    # size  string  optional  size of animal (S=small, M=medium, L=large, XL=extra-large)
    # sex character optional  M=male, F=female
    # location  string  optional  the ZIP/postal code or city and state the animal should be located (NOTE: the closest possible animal will be selected)
    # shelterid string  optional  ID of the shelter that posted the pet
    # output  string  optional (default=id) How much of the pet record to return: id, basic, full
    def get_random_pet(opts={})
      res = Client.get('/pet.getRandom', :query => opts)
      Pet.new(res) unless res.nil?
    end
    
    
    
  
  end
end 


