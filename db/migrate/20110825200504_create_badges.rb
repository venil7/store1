class CreateBadges < ActiveRecord::Migration
  def self.up
    create_table :badges do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    Badge.create :name=>"slider", :description=>"slider"
  end

  def self.down
    drop_table :badges
  end
end

