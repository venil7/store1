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

  def pdf
    send_data @order.to_pdf, :filename => @order.pdf_name
  end

  def invoice
    begin
      @order = Order.find(flash[:order_id])
      send_data @order.to_pdf, :filename => @order.pdf_name
    rescue
      redirect_to :controller => :store, :action => :index
    end
  end

  #this action is run straight after paypal authorisation
  def paypal_confirm
    @token, @payer_id = params[:token], params[:PayerID]
    if @token and @payer_id
      @details = EXPRESS_GATEWAY.details_for(@token)

      if @details.success?
        @address = "#{@details.address['company']} #{@details.address['address1']} #{@details.address['address2']} #{@details.address['city']} #{@details.address['state']} #{@details.address['zip']} #{@details.address['country']}"
        @cart.update_attributes! :name => @details.name,
                                 :address => @address,
                                 :email => @details.email,
                                 :phone => @details.contact_phone,
                                 :instructions => @details.message
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
    @bank_transfer_details = BankTransferDetails.new if request.get?
    if request.post?
      @bank_transfer_details = BankTransferDetails.new(params[:bank_transfer_details])
      if @bank_transfer_details.valid?
        cart.apply_bank_transfer_details(@bank_transfer_details)
        @cart.source = :bank_transfer
        send_emails
        render :action => "success"
        #send_data cart.to_pdf, :filename => "invoice.pdf"
        mark_completed :forget => true
      end
    end
  end
  
  #perform purchase after confirmation
  def paypal_success
    @token, @payer_id = params[:token], params[:payer_id]
    if request.post? and @token and @payer_id
      @result =  EXPRESS_GATEWAY.purchase(cart.total_cents, {:ip => request.remote_ip, :token => @token, :payer_id => @payer_id})
      if @result.success?
        send_emails
        mark_completed :forget => true
        render :action => "success"        
      else
        flash[:error] = "could not perform EXPRESS_GATEWAY.purchase"
        redirect_to :controller=>:store, :action=>:error
      end
    else
      flash[:error] = "could not find token or payer id"
      redirect_to :controller=>:store, :action=>:error
    end
  end

  def success
    #happy path, rendesr success
  end

  def cancel
    flash[:notice] = "transaction cancelled"
    redirect_to :controller => :store, :action => :edit
  end

  private
  def send_emails
    #send us an email
    UserMailer.new_order_admin(cart).deliver
    #send them an email
    UserMailer.new_order_customer(cart).deliver
    #finish off
  end
  
  def set_reference_data
    @cart = cart
    @menu_item = :cart
  end
end

