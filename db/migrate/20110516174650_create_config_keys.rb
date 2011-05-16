class CreateConfigKeys < ActiveRecord::Migration
  def self.up
    create_table :config_keys do |t|
	  t.string:"twitter_consumer_key"
	  t.string:"twitter_consumer_secret"
	  t.string:"twitter_oauth_token"
	  t.string:"twitter_oauth_secret"
	  t.string:"facebook_fan_page"
	  t.string:"facebook_access_token"
	  t.string:"google_email"
	  t.string:"google_email_password"
      t.timestamps
    end
  end

  def self.down
    drop_table :config_keys
  end
end
