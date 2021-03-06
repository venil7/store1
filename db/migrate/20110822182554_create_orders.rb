class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.string :instructions
      t.boolean :completed, :default => false
      t.boolean :shipped, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end

