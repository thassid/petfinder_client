# Petfinder Client
This gem wraps the read-only, Petfinder.com API.  

[http://www.petfinder.com/developers/api-docs](http://www.petfinder.com/developers/api-docs)

## Initiating Client

    `require 'pet_finder'`

    `client = PetFinder::Client.new('MyApiKey')`

## Client Methods

***

### find_shelters(location, opts={})
* location - string - zip code or city and state
* Options:
  * name - string - shelter name
  * offset - integer
  * count - integer
    
            shelters = client.find_shelters(92012)
            shelters = client.find_shelters('San Diego, CA', {:count => 10})

Returns: 
Array of Shelters    
 
*** 
    
### get\_shelter(shelter\_id, opts={})
* shelter_id - string - shelter id


        shelter = client.get_shelter('MyShelterId')
    

Returns:
Shelter Object

***

### list_breeds(animal)
* animal - string - type of animal (barnyard, bird, cat, dog, horse, pig, reptile, smallfurry)

        dog_breeds = client.list_breeds('dog')

Returns:
Array of Strings

***

### find_pets(location, opts={})
* location - string - zip code or city and state
* Options:
  * animal - string	-	type of animal (barnyard, bird, cat, dog, horse, pig, reptile, smallfurry)
  * breed - string - breed of animal (use pet.listBreeds for a list of valid breeds)
  * size - string - size of animal (S=small, M=medium, L=large, XL=extra-large)
  * sex - character - M=male, F=female
  * age - string - age of the animal (Baby, Young, Adult, Senior)
  * offset - string - set this to the value of lastOffset returned by a previous call to pet.find, and it will retrieve the next result set
  * count - integer - how many records to return for this particular API call (default is 25)
  * output - string - (default=basic)  How much of each record to return: basic (no description) or full (includes description)

            pets = client.find_pets(92102, {:count => 50, :breed => 'Collie', :output => 'basic'})

Returns:
Array of Pets

***

### list\_shelters\_with\_breed(animal, breed, opts={})
* animal - string - type of animal (barnyard, bird, cat, dog, horse, pig, reptile, smallfurry)
* breed - string - breed of animal(use pet.listBreeds for a list of valid breeds)
* Options:
  * offset 
  * count 
  
            shelters = client.list\_shelters\_with_breed('dog', 'collie')
    
Return:
Array of Shelters

***

### get_pet(pet_id)
* pet_id - string

        pet = client.get_pet('MyPetId')
    
Returns:
Pet Object

***

## Shelter Methods

### Attributes of Shelter
* id
* address1 
* address2
* city
* country
* email
* fax
* latitude
* longitude
* name
* phone
* state
* zip

***

### get_pets(opts={})
* Options:
  * status - character (default=A, public may only list adoptable pets) A=adoptable, H=hold, P=pending, X=adopted/removed
  * count - integer
  * offset - integer
  * output string  (default=basic)  How much of the pet record to return: id, basic (no description), full
  
            pets = shelter.get_pets({:count => 25})

Returns:
Array of Pets    
    
***

## Pet Methods

### Attributes of Pet
* id
* animal
* breeds
* mix
* age
* name
* shelterId
* size
* sex
* description
* lastUpdate
* status
* contact

***

### get_photos

      photos = pet.get_photos
    
Returns:

      {
        "500x500"=>"url string", 
        "max50\_height"=>"url string"
        "300x250"=>"url string", 
        "max60\_wide"=>"url string", 
        "max95_wide"=>"url string"
      }  
    