module PetFinder
  class Pet
    
    attr_accessor :id, :animal, :breeds, :mix, :age, :name, :shelterId, :size, :sex, :description, :lastUpdate, :status, :media, :contact
    
    def initialize(atts={})
      atts.each do |key, value|
        self.send("#{key}=", value) if respond_to?(key)
      end
    end
    
    def get_photos
      my_photos = {}
      photos = media['photos']['photo']
      all_photos = []
      0..5.times do |x|
        all_photos << photos.select do |p|
          p_id = p.match(/([1-5])-\w+\.jpg$/)[1]
          p_id == x.to_s
        end
      end
      all_photos.each_with_index do |photo_array, idx|
        res_hash = {
          '500x500' => nil,
          'max50_height' => nil,
          '300x250' => nil,
          'max60_wide' => nil,
          'max95_wide' => nil
        }
        photo_array.each do |photo_url|
          res_hash['500x500'] = photo_url if photo_url.match(/x\.jpg$/)
          res_hash['max50_height'] = photo_url if photo_url.match(/t\.jpg$/)
          res_hash['300x250'] = photo_url if photo_url.match(/pn\.jpg$/)
          res_hash['max60_wide'] = photo_url if photo_url.match(/pnt\.jpg$/)
          res_hash['max95_wide'] = photo_url if photo_url.match(/fpm\.jpg$/)
        end
        my_photos["photo_#{idx.to_s}"] = res_hash unless res_hash.values.compact.empty?
      end
      my_photos      
    end
  
  end
end