class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
		 t.string :name
		  t.string :mp3
		   t.string :oga
      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
