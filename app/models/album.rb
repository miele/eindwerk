class Album < ActiveRecord::Base

has_many :pictures, :dependent => :destroy
accepts_nested_attributes_for :pictures, :allow_destroy => true

 has_attached_file :cover, :styles => { :large => "800x600", :medium => "300x300>", :thumb => "200x200>" }
 
  def self.search(search)
 	if search
 		where('name LIKE ?', "%#{search}%")
 	else
 		scoped
 	end
 end
 
end
