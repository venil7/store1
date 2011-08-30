class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :product_id
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
