class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.integer :category_id
      t.integer :badge_id
      t.string :short_description
      t.string :long_description
      t.integer :discount, :default => 0
      t.float :price, :default => 0.0
      t.integer :stock, :default => 0

      t.timestamps
    end

    add_index :products, :category_id
    add_index :products, :badge_id
    add_index :products, :sku
  end

  def self.down
    drop_table :products
  end
end

