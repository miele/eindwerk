class CreateTwitterUpdates < ActiveRecord::Migration
  def self.up
    create_table :twitter_updates do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :twitter_updates
  end
end
