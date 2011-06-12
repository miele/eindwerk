class AddLinkToConfig < ActiveRecord::Migration
  def self.up
    add_column :config_keys, :facebook_link, :string
    add_column :config_keys, :twitter_link, :string
    add_column :config_keys, :myspace_link, :string
    add_column :config_keys, :facebook_app_id, :string
    add_column :config_keys, :booking_mail, :string
  end

  def self.down
  	remove_column :config_keys, :facebook_link, :string
    remove_column :config_keys, :twitter_link, :string
    remove_column :config_keys, :myspace_link, :string
    remove_column :config_keys, :facebook_app_id, :string
    remove_column :config_keys, :booking_mail, :string
  end
end
