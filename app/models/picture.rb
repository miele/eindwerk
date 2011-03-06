class Picture < ActiveRecord::Base
  attr_accessible :album_id, :upload 
  belongs_to :album 
  has_attached_file :upload,
  					:styles => { :large => "1280x960",
 									    :medium => "300x300>",
 									    :thumb => "200x200>" }  
end
