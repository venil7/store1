class Order < ActiveRecord::Base
  has_many :cartitems, :dependent => :destroy
  has_many :products, :through => :cartitems

  scope :completed, order("updated_at").where(:completed => true)

  def add_product(product_id)
    save if !persisted?
    @cartitem = product_ids.include?(product_id) ?
      cartitems.select{|c| c.product_id == product_id}.first :
      Cartitem.new(:order_id => id,:product_id => product_id)
    @cartitem.amount += 1
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

  def total_cents
    sub_total * 100
  end

  def empty?
    !cartitems.any?
  end
end

