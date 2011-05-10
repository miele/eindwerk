class AddPaCheckToContacts < ActiveRecord::Migration
  def self.up
  	add_column :contacts, :beschrijving_optreden, :string
    add_column :contacts, :pa, :integer
  end

  def self.down
  	remove_column :contacts, :beschrijving_optreden, :string
    remove_column :contacts, :pa, :integer
  end
end
