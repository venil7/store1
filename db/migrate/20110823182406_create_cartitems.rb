class CreateCartitems < ActiveRecord::Migration
  def self.up
    create_table :cartitems do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :amount, :null => false, :default => 0

      #t.timestamps
    end
  end

  def self.down
    drop_table :cartitems
  end
end
