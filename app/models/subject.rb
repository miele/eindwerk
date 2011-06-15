class Subject < ActiveRecord::Base

 has_many :pages
 
 # validates_presence_of :name, :content
#  validates_length_of :name, :within => 2..15, :too_short => "Je moet meer tekens gebruiken", :too_long => "Je titel is te lang!"
#  validates_length_of :content, :within => 10..250, :too_short => "Je moet meer tekst gebruiken", :too_long => "Je tekst is te lang!"

 scope :visible, where(:visible => true)
 scope :invisible, where(:visible => false)
 scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}
 
 #het omvormen van de opgeladen foto's naar zwart/wit voor het grafische design te volgen
 
 has_attached_file :photo, :styles => { :large => "1000x800",
 									    :medium => "300x300>",
 									    :thumb => "200x200>" },
 				    :convert_options => { 	:thumb => "-colorspace Gray",
 											:large => "-colorspace Gray",
 											}
 
 
 def self.search(search)
 	if search
 		where('name LIKE ?', "%#{search}%")
 	else
 		scoped
 	end
 end
 
end
