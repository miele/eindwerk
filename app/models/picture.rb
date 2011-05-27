class Picture < ActiveRecord::Base
  attr_accessible :album_id, :upload 
  belongs_to :album 
  has_attached_file :upload,
  					:styles => { :large => "800x600",
 									    :medium => "300x300>",
 									    :thumb => "200x200>" }
#  validates_attachment_presence :upload
#   validates_attachment_content_type :upload, :content_type => [/image\/jpg/, /image\/jpeg/, /image\/pjpeg/, /image\/gif/, /image\/png/, /image\/x-png/]
  
end
