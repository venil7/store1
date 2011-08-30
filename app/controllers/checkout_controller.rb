class CheckoutController < CartController
  def index
    #save cart to db
    #redirect to paypal express
    response = EXPRESS_GATEWAY.setup_purchase(cart.total_cents,
      :ip                => request.remote_ip,
      :return_url        => url_for(:controller => :checkout, :action => :success, :only_path => false),
      :cancel_return_url => url_for(:controller => :checkout, :action => :cancel, :only_path => false))
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def success
    @cents = cart.total_cents
    @token = params[:token]
    @payer_id = params[:PayerID]
    @result =  EXPRESS_GATEWAY.purchase(@cents, {:ip => request.remote_ip, :token => @token, :payer_id => @payer_id})
    mark_completed
    forget_cart
    render :text => :order_completed
  end

  def cancel
    render :text => :cancelled
  end

  #private
  def savecart
    @cart = cart
    @order = Order.new
    @products = [3,3,3,3]
    #    @cart.each {|index, item|
    #  item[:count].times {
    #    @products << item[:item]
    #  }
    #}
    @order.products_singular_ids = @products
    @order.save!
  end
end
