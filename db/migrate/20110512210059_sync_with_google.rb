class SyncWithGoogle < ActiveRecord::Migration
  def self.up
  add_column :googles, :start_time, :datetime
    add_column :googles, :end_time, :datetime
     add_column :googles, :title, :string
    add_column :googles, :where, :string
  end

  def self.down
   remove_column :googles, :start_time, :datetime
    remove_column :googles, :end_time, :datetime
     remove_column :googles, :title, :string
    remove_column :googles, :where, :string

  end
end
