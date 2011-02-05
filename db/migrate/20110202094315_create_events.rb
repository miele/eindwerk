class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.date :start_at
      t.date :end_at
      t.string :place
      t.time :aanvang
      
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
