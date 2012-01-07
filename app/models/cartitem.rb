class Cartitem < ActiveRecord::Base
  #include Payday::LineItemable

  belongs_to :order
  belongs_to :product

  #payday lineItem methods
  # def description
  #   product.short_description
  # end

  # def display_price
  #   product.final_price
  # end

  # def price
  # 	product.final_price
  # end

  # def display_quantity
  # 	#self.amount.to_s
  #   1
  # end

  # def quantity
  # 	#self.amount
  #   1
  # end
end
