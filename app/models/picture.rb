class Picture < ActiveRecord::Base
  attr_accessible :album_id, :upload 
  belongs_to :album 
  has_attached_file :upload,
  					:url  => "/pics/:id/:basename.:extension",
                  :path => ":rails_root/public/pics/:id/:basename.:extension",
   :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
end
