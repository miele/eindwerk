class AddTwitterUsernameToConfig < ActiveRecord::Migration
  def self.up
  add_column :config_keys, :twitter_username, :string
  end

  def self.down
  remove_column :config_keys, :twitter_username, :string
  end
end
