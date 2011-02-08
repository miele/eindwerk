class AddContentToSubjects < ActiveRecord::Migration
  def self.up
  	add_column :subjects, :content, :text
  end

  def self.down
  	remove_column :subjects, :content, :text
  end
end
