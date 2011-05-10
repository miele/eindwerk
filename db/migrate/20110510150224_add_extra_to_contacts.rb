class AddExtraToContacts < ActiveRecord::Migration
  def self.up
  	add_column :contacts, :datum_optreden, :datetime
    add_column :contacts, :naam_optreden, :string
    add_column :contacts, :adres_optreden, :string
    add_column :contacts, :aanvang_optreden, :datetime
    add_column :contacts, :loon, :integer
    add_column :contacts, :arriveren, :datetime
    add_column :contacts, :soundcheck, :datetime
    add_column :contacts, :eten_info, :string
    add_column :contacts, :guest_list,:integer
  end

  def self.down
  	remove_column :contacts, :datum_optreden, :datetime
    remove_column :contacts, :naam_optreden, :string
    remove_column :contacts, :adres_optreden, :string
    remove_column :contacts, :aanvang_optreden, :datetime
    remove_column :contacts, :loon, :integer
    remove_column :contacts, :arriveren, :datetime
    remove_column :contacts, :soundcheck, :datetime
    remove_column :contacts, :eten_info, :string
    remove_column :contacts, :guest_list,:integer
  end
end
