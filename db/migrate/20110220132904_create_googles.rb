class CreateGoogles < ActiveRecord::Migration
  def self.up
    create_table :googles do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :googles
  end
end
