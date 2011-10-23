class AddCategoryIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :category_id, :integer
    add_column :products, :badge_id, :integer
  end

  def self.down
    remove_column :products, :category_id
    remove_column :products, :badge_id
  end
end

