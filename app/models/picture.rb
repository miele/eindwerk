class Picture < ActiveRecord::Base
belongs_to :album

 has_attached_file :upload,
                    :url => "/images/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/images/:id/:style/:basename.:extension",
                    :styles => {
                      :thumb => "75x75>",
                      :small => "200x200>"
                    }

end
