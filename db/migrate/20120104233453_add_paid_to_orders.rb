class AddPaidToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :paid, :boolean, :default => false
    add_column :orders, :source, :string
  end

  def self.down
    remove_column :orders, :source
    remove_column :orders, :paid
  end
end
