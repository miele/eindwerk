class Album < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy
  
  def self.search(search)
 	if search
 		where('name LIKE ?', "%#{search}%")
 	else
 		scoped
 	end
 end
  
  
end
