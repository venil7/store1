class AddShippedToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :shipped, :boolean
  end

  def self.down
    remove_column :products, :shipped
  end
end
