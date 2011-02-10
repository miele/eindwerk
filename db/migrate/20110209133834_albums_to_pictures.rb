class AlbumsToPictures < ActiveRecord::Migration
  def self.up
  create_table :albums_pictures, :id => false do |t|
   t.integer "album_id"
   t.integer "picture_id"
  end
  add_index :albums_pictures, ["album_id","picture_id"]
  end

  def self.down
   drop_table :albums_pictures
  end
end
