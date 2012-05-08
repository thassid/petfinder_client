$:.unshift(File.join(File.dirname(__FILE__)))
$:.unshift(File.join(File.dirname(__FILE__), "../lib"))
require 'rubygems'
require 'rspec'
require 'vcr'
require 'active_support/core_ext'

require 'pet_finder'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.stub_with :webmock
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

CASSETTE_BASE_PATH = 'spec/cassettes/PetFinder_Client/'

def two_shelters
  res = []
  # note: this is really just testing HTTParty...
  # yaml = YAML.load(File.open(CASSETTE_BASE_PATH + 'finding_list_of_shelters.yml'))
  # xml = get_cassette_xml(yaml)
  # doc = Nokogiri(xml)
  # doc.xpath('//shelters/shelter').each do |node|
  #   res << PetFinder::Shelter.new(Hash.from_xml(node.to_s)['shelter'])
  # end
  shelter_ids = ['CA1080','CA1482']
  shelter_ids.each{|id| res <<  PetFinder::Shelter.new({:id => id})}
  res
end

def one_shelter
  two_shelters[0]
end

def dog_breeds_list
  #   yaml = YAML.load(File.open(CASSETTE_BASE_PATH + 'list_breeds.yml'))
  #   xml = get_cassette_xml(yaml)
  #   doc = Nokogiri(xml)
  #   Hash.from_xml(doc.xpath('//breeds').to_s)['breeds']['breed']
  ["Affenpinscher", "Afghan Hound", "Airedale Terrier", "Akbash", "Akita", "Alaskan Malamute", "American Bulldog", "American Eskimo Dog", "American Hairless Terrier", "American Staffordshire Terrier", "American Water Spaniel", "Anatolian Shepherd", "Appenzell Mountain Dog", "Australian Cattle Dog (Blue Heeler)", "Australian Kelpie", "Australian Shepherd", "Australian Terrier", "Basenji", "Basset Hound", "Beagle", "Bearded Collie", "Beauceron", "Bedlington Terrier", "Belgian Shepherd Dog Sheepdog", "Belgian Shepherd Laekenois", "Belgian Shepherd Malinois", "Belgian Shepherd Tervuren", "Bernese Mountain Dog", "Bichon Frise", "Black and Tan Coonhound", "Black Labrador Retriever", "Black Mouth Cur", "Black Russian Terrier", "Bloodhound", "Blue Lacy", "Bluetick Coonhound", "Boerboel", "Bolognese", "Border Collie", "Border Terrier", "Borzoi", "Boston Terrier", "Bouvier des Flanders", "Boxer", "Boykin Spaniel", "Briard", "Brittany Spaniel", "Brussels Griffon", "Bull Terrier", "Bullmastiff", "Cairn Terrier", "Canaan Dog", "Cane Corso Mastiff", "Carolina Dog", "Catahoula Leopard Dog", "Cattle Dog", "Caucasian Sheepdog (Caucasian Ovtcharka)", "Cavalier King Charles Spaniel", "Chesapeake Bay Retriever", "Chihuahua", "Chinese Crested Dog", "Chinese Foo Dog", "Chinook", "Chocolate Labrador Retriever", "Chow Chow", "Cirneco dell'Etna", "Clumber Spaniel", "Cockapoo", "Cocker Spaniel", "Collie", "Coonhound", "Corgi", "Coton de Tulear", "Curly-Coated Retriever", "Dachshund", "Dalmatian", "Dandi Dinmont Terrier", "Doberman Pinscher", "Dogo Argentino", "Dogue de Bordeaux", "Dutch Shepherd", "English Bulldog", "English Cocker Spaniel", "English Coonhound", "English Pointer", "English Setter", "English Shepherd", "English Springer Spaniel", "English Toy Spaniel", "Entlebucher", "Eskimo Dog", "Feist", "Field Spaniel", "Fila Brasileiro", "Finnish Lapphund", "Finnish Spitz", "Flat-coated Retriever", "Fox Terrier", "Foxhound", "French Bulldog", "Galgo Spanish Greyhound", "German Pinscher", "German Shepherd Dog", "German Shorthaired Pointer", "German Spitz", "German Wirehaired Pointer", "Giant Schnauzer", "Glen of Imaal Terrier", "Golden Retriever", "Gordon Setter", "Great Dane", "Great Pyrenees", "Greater Swiss Mountain Dog", "Greyhound", "Harrier", "Havanese", "Hound", "Hovawart", "Husky", "Ibizan Hound", "Illyrian Sheepdog", "Irish Setter", "Irish Terrier", "Irish Water Spaniel", "Irish Wolfhound", "Italian Greyhound", "Italian Spinone", "Jack Russell Terrier", "Jack Russell Terrier (Parson Russell Terrier)", "Japanese Chin", "Jindo", "Kai Dog", "Karelian Bear Dog", "Keeshond", "Kerry Blue Terrier", "Kishu", "Klee Kai", "Komondor", "Kuvasz", "Kyi Leo", "Labrador Retriever", "Lakeland Terrier", "Lancashire Heeler", "Leonberger", "Lhasa Apso", "Lowchen", "Maltese", "Manchester Terrier", "Maremma Sheepdog", "Mastiff", "McNab", "Miniature Pinscher", "Mountain Cur", "Mountain Dog", "Munsterlander", "Neapolitan Mastiff", "New Guinea Singing Dog", "Newfoundland Dog", "Norfolk Terrier", "Norwegian Buhund", "Norwegian Elkhound", "Norwegian Lundehund", "Norwich Terrier", "Nova Scotia Duck-Tolling Retriever", "Old English Sheepdog", "Otterhound", "Papillon", "Patterdale Terrier (Fell Terrier)", "Pekingese", "Peruvian Inca Orchid", "Petit Basset Griffon Vendeen", "Pharaoh Hound", "Pit Bull Terrier", "Plott Hound", "Podengo Portugueso", "Pointer", "Polish Lowland Sheepdog", "Pomeranian", "Poodle", "Portuguese Water Dog", "Presa Canario", "Pug", "Puli", "Pumi", "Rat Terrier", "Redbone Coonhound", "Retriever", "Rhodesian Ridgeback", "Rottweiler", "Saint Bernard St. Bernard", "Saluki", "Samoyed", "Sarplaninac", "Schipperke", "Schnauzer", "Scottish Deerhound", "Scottish Terrier Scottie", "Sealyham Terrier", "Setter", "Shar Pei", "Sheep Dog", "Shepherd", "Shetland Sheepdog Sheltie", "Shiba Inu", "Shih Tzu", "Siberian Husky", "Silky Terrier", "Skye Terrier", "Sloughi", "Smooth Fox Terrier", "South Russian Ovtcharka", "Spaniel", "Spitz", "Staffordshire Bull Terrier", "Standard Poodle", "Sussex Spaniel", "Swedish Vallhund", "Terrier", "Thai Ridgeback", "Tibetan Mastiff", "Tibetan Spaniel", "Tibetan Terrier", "Tosa Inu", "Toy Fox Terrier", "Treeing Walker Coonhound", "Vizsla", "Weimaraner", "Welsh Corgi", "Welsh Springer Spaniel", "Welsh Terrier", "West Highland White Terrier Westie", "Wheaten Terrier", "Whippet", "White German Shepherd", "Wire Fox Terrier", "Wire-haired Pointing Griffon", "Wirehaired Terrier", "Xoloitzcuintle (Mexican Hairless)", "Yellow Labrador Retriever", "Yorkshire Terrier Yorkie"]
end

def two_pets
  res = []
  #   yaml = YAML.load(File.open(CASSETTE_BASE_PATH + 'finding_list_of_pets.yml'))
  #   xml = get_cassette_xml(yaml)
  #   doc = Nokogiri(xml)
  #   doc.xpath('//pets/pet').each{|node| res << PetFinder::Pet.new(Hash.from_xml(node.to_s)['pet'])}
  pet_ids = ['19901761','20775306']
  pet_ids.each{|id| res << PetFinder::Pet.new({:id => id})}
  res
end

def one_pet
  two_pets[0]
end

def full_pet_objs
  res = []
  yaml = YAML.load(File.open(CASSETTE_BASE_PATH + 'finding_list_of_pets.yml'))
  xml = get_cassette_xml(yaml)
  doc = Nokogiri(xml)
  doc.xpath('//pets/pet').each{|node| res << PetFinder::Pet.new(Hash.from_xml(node.to_s)['pet'])}
  res
end

def pet_photos_hash
  my_pet_photos = {}
  yaml = YAML.load(File.open(CASSETTE_BASE_PATH + 'finding_list_of_pets.yml'))
  xml = get_cassette_xml(yaml)
  doc = Nokogiri(xml)
  first_pet_photos_node = doc.xpath('//pets/pet/media/photos')[0]
  all_photos = []
  0..5.times do |x|
    all_photos << first_pet_photos_node.children.select{|node| node['id'] == x.to_s}
  end
  all_photos.each_with_index do |photo_array, idx|
    res_hash = {
      '500x500' => nil,
      'max50_height' => nil,
      '300x250' => nil,
      'max60_wide' => nil,
      'max95_wide' => nil
    }
    photo_array.each do |photo_node|
      res_hash['500x500'] = photo_node.text if photo_node.text.match(/x\.jpg$/)
      res_hash['max50_height'] = photo_node.text if photo_node.text.match(/t\.jpg$/)
      res_hash['300x250'] = photo_node.text if photo_node.text.match(/pn\.jpg$/)
      res_hash['max60_wide'] = photo_node.text if photo_node.text.match(/pnt\.jpg$/)
      res_hash['max95_wide'] = photo_node.text if photo_node.text.match(/fpm\.jpg$/)
    end
    my_pet_photos["photo_#{idx.to_s}"] = res_hash unless res_hash.values.compact.empty?
  end
  my_pet_photos
end

def two_shelter_pets
  res = []
  # yaml = YAML.load(File.open('spec/cassettes/PetFinder_Shelter/shelter_pets.yml'))
  # xml = get_cassette_xml(yaml)
  # doc = Nokogiri(xml)
  # doc.xpath('//pets/pet').each{|node| res << PetFinder::Pet.new(Hash.from_xml(node.to_s)['pet'])}
  pet_ids = ['10937712','11482281']
  pet_ids.each{|id| res << PetFinder::Pet.new({:id => id})}
  res
end

def get_cassette_xml(yaml)
  yaml['http_interactions'][0]['response']['body']['string']
end




