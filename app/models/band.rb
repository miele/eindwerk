class Band < ActiveRecord::Base

validates :name, :presence => true, :length => { :minimum => 3 }

 has_attached_file :picture, :styles => { :large => "800x600", :medium => "300x300>", :thumb => "200x200>" }

 def self.search(search)
 	if search
 		where('name LIKE ?', "%#{search}%")
 	else
 		scoped
 	end
 end
 

end
