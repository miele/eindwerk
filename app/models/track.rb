class Track < ActiveRecord::Base

has_attached_file :song,
                  :url  => "/mp3/:id/:basename.:extension",
                  :path => ":rails_root/public/mp3/:id/:basename.:extension"

validates_attachment_presence :song
  validates_attachment_size :song, :less_than => 10.megabytes,
    :message => 'filesize must be less than 10 MegaBytes'
  validates_attachment_content_type :song, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ],
                :message => 'file must be of filetype .mp3'


def self.search(search)
 	if search
 		where('name LIKE ?', "%#{search}%")
 	else
 		scoped
 	end
 end

end
