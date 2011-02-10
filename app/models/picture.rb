class Picture < ActiveRecord::Base
belongs_to :album

 has_attached_file :upload,
                    :url => "/images/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/images/:id/:style/:basename.:extension",
                    :styles => {
                      :thumb => "200x200>",
                      :small => "300x300>",
                      :large => "800x600>"

                    }

end
