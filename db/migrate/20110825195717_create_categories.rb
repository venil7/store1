class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.integer :category_id

      t.timestamps
    end

    add_index :categories, :category_id
    Category.create :name => "General", :description => "Genereal"
  end

  def self.down
    drop_table :categories
  end
end

