class AddCategoryIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :category_id, :intereger
    add_column :products, :badge_id, :intereger
  end

  def self.down
    remove_column :products, :category_id
    remove_column :products, :badge_id
  end
end
