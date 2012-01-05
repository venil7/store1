class Order < ActiveRecord::Base
  has_many :cartitems, :dependent => :destroy
  has_many :products, :through => :cartitems

  scope :completed, order("updated_at").where(:completed => true)
  scope :shipped, order("updated_at").where(:shipped => true)

  def add_product(product_id, amount=1)
    save if !persisted?
    @cartitem = product_ids.include?(product_id) ?
      cartitems.select{|c| c.product_id == product_id}.first :
      Cartitem.new(:order_id => id,:product_id => product_id,:amount => 0)
    @cartitem.amount += amount
    @cartitem.save
    #reload
  end

  def update_amounts(quantities)
    quantities.each { |product_id, amount|
      if (product_ids.include?(product_id.to_i))
        cartitems
        .select{|c| c.product_id == product_id.to_i}
        .first
        .update_attributes!(:amount => amount)
      end
    }
  end

  def apply_bank_transfer_details(bank_transfer_details)
    self.name = bank_transfer_details.name
    self.address = bank_transfer_details.address
    self.email = bank_transfer_details.email
    self.phone = bank_transfer_details.phone
    self.instructions = bank_transfer_details.instructions 
  end


  def delete_product(product_id)
    @cartitem = cartitems.select{|c| c.product_id == product_id}.first
    @cartitem.destroy
  end

  def sub_total
    @sub_total = 0
    cartitems.each { |c|
      @sub_total += c.product.final_price * c.amount
    }
    @sub_total
  end

  def total
    free_shipping? ? sub_total : sub_total + SETTING.shipping_cost
  end

  def total_cents
    total * 100
  end

  def empty?
    !cartitems.any?
  end

  def free_shipping?
    sub_total >= SETTING.free_shipping_threshold
  end

  def shipping_cost
    #total - sub_total
    free_shipping? ? 0.0 : SETTING.shipping_cost
  end
end

