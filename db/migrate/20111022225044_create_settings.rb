class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.float :shipping_cost, :default => 5.0
      t.float :free_shipping_threshold, :default => 50.0

    end

    Setting.create :shipping_cost => 5.0, :free_shipping_threshold => 50.0
  end

  def self.down
    drop_table :settings
  end
end

