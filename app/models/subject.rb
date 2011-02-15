class Subject < ActiveRecord::Base

 has_many :pages

 scope :visible, where(:visible => true)
 scope :invisible, where(:visible => false)
 scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}
 has_attached_file :photo, :styles => { :large => "800x600", :medium => "300x300>", :thumb => "200x200>" },
 :convert_options => { :thumb => "-colorspace Gray",
 :large => "-colorspace Gray" }

 
 def self.search(search)
 	if search
 		where('name LIKE ?', "%#{search}%")
 	else
 		scoped
 	end
 end
 
end
