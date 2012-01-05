class CreateBankTransferDetails < ActiveRecord::Migration
  def self.up
    create_table :bank_transfer_details do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bank_transfer_details
  end
end
