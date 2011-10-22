class AddCustomerToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :name, :string
    add_column :orders, :address, :string
    add_column :orders, :email, :string
    add_column :orders, :phone, :string
  end

  def self.down
    remove_column :orders, :phone
    remove_column :orders, :email
    remove_column :orders, :address
    remove_column :orders, :name
  end
end
