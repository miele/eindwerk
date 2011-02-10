class AddFkToPictures < ActiveRecord::Migration
  def self.up
  	add_column :pictures, :album_id, :int
  end

  def self.down
  remove_column :pictures, :album_id, :int
  end
end
