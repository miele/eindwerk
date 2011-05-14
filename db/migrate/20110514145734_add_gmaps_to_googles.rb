class AddGmapsToGoogles < ActiveRecord::Migration
  def self.up
  add_column :googles, :latitude, :float #you can change the name, see wiki
  add_column :googles, :longitude, :float #you can change the name, see wiki
  add_column :googles, :gmaps, :boolean #not mandatory, see wiki
  end

  def self.down
  remove_column :googles, :latitude, :float #you can change the name, see wiki
  remove_column :googles, :longitude, :float #you can change the name, see wiki
  remove_column :googles, :gmaps, :boolean #not mandatory, see wiki
  end
end
