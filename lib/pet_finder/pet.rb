module PetFinder
  class Pet
    
    attr_accessor :id, :animal, :breeds, :mix, :age, :name, :shelterId, :size, :sex, :description, :lastUpdate, :status, :media, :contact
    
    def initialize(atts={})
      atts.each do |key, value|
        self.send("#{key}=", value) if respond_to?(key)
      end
    end
    
    def get_photos
      media['photos']['photo']
    end
    
    def get_thumbnails
      # TODO...
    end
    
    
  end
end