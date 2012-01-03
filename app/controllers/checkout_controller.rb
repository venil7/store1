class CheckoutController < CartController
  before_filter :set_reference_data
  def paypal
    #redirect to paypal express
    response = EXPRESS_GATEWAY.setup_purchase(cart.total_cents,
      :ip                => request.remote_ip,
      :return_url        => url_for(:controller => :checkout, :action => :paypal_confirm, :only_path => false),
      :cancel_return_url => url_for(:controller => :checkout, :action => :cancel, :only_path => false),
      :order_id          => cart.id)
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  #this action is run straight after paypal authorisation
  def paypal_confirm
    @token, @payer_id = params[:token], params[:PayerID]
    if @token and @payer_id
      @details = EXPRESS_GATEWAY.details_for(@token)

      if @details.success?
        @address = "#{@details.address['company']} #{@details.address['address1']} #{@details.address['address2']} #{@details.address['city']} #{@details.address['state']} #{@details.address['zip']} #{@details.address['country']}"
        @cart.update_attributes! :name=>@details.name,
                                 :address=>@address,
                                 :email=>@details.email,
                                 :phone=>@details.contact_phone,
                                 :instructions=>@details.message
      else
        flash[:error] = "could not perform EXPRESS_GATEWAY.details"
        redirect_to :controller=>:store, :action=>:error
      end
    else
      flash[:error] = "could not find token or payer id"
      redirect_to :controller=>:store, :action=>:error
    end
  end

  #bank transfer checkout
  def bank_transfer
    if request.post?
    end
  end
  
  
  #perform purchase after confirmation
  def success
    @token, @payer_id = params[:token], params[:payer_id]
    if request.post? and @token and @payer_id
      @result =  EXPRESS_GATEWAY.purchase(cart.total_cents, {:ip => request.remote_ip, :token => @token, :payer_id => @payer_id})
      if @result.success?
        #send us an email
        UserMailer.new_order_admin(cart).deliver
        #send them an email
        UserMailer.new_order_customer(cart,cart.email).deliver
        #finish off
        mark_completed :forget => true
        @email = cart.email
      else
        flash[:error] = "could not perform EXPRESS_GATEWAY.purchase"
        redirect_to :controller=>:store, :action=>:error
      end
    else
      flash[:error] = "could not find token or payer id"
      redirect_to :controller=>:store, :action=>:error
    end
  end

  def cancel
    flash[:notice] = "transaction cancelled"
    redirect_to :controller => :store, :action => :edit
  end

  private
  def set_reference_data
    @cart = cart
    @menu_item = :cart
  end
end

