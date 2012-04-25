module PetFinder
  class Pet
    
    attr_accessor :id, :animal, :breeds, :mix, :age, :name, :shelterId, :size, :sex, :description, :lastUpdate, :status, :media, :contact
    
    def initialize(atts={})
      atts.each do |key, value|
        self.send("#{key}=", value) if respond_to?(key)
      end
    end
    
    def get_photos
      photos = media['photos']['photo']
      {
        '500x500' => photos.select{|p| p.match(/x\.jpg$/)}[0],
        'max50_height' => photos.select{|p| p.match(/t\.jpg$/)}[0],
        '300x250' => photos.select{|p| p.match(/pn\.jpg$/)}[0],
        'max60_wide' => photos.select{|p| p.match(/pnt\.jpg$/)}[0],
        'max95_wide' => photos.select{|p| p.match(/fpm\.jpg$/)}[0]
      }
    end
        
  end
end