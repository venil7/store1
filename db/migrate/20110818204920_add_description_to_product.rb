class AddDescriptionToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :short_description, :string
    add_column :products, :long_description, :string
    add_column :products, :discount, :integer, :default => 0
  end


  def self.down
    remove_column :products, :short_description, :string
    remove_column :products, :long_description, :string
    remove_column :products, :discount, :integer
  end
end
