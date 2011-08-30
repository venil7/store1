class CartController < ActionController::Base
  layout 'application'
  before_filter :init_cart

  protected
  def cart
    @order
  end

  def init_cart
    @order = Order.where(:id=>session[:order_id]).first
    @order ||= Order.new
  end

  def add_to_cart(id)
    @order.add_product(id.to_i)
    session[:order_id] = @order.id
  end

  def delete_from_cart(id)
    @order.delete_product(id.to_i)
  end

  def clear_cart
    @order.destroy if @order.persisted?
    session[:order_id] = nil
  end

  def mark_completed
    @order.completed = true
    @order.save
  end

  def forget_cart
    session[:order_id] = nil
  end
end
