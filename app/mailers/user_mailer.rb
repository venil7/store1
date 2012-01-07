class UserMailer < ActionMailer::Base
  default APP_CONFIG["mailer_default"].to_options
  helper :application

  def new_order_admin(order)
    @order = order
    attachments[@order.pdf_name] = @order.to_pdf
    mail(:subject => "Order #{@order.id}")
  end

  def new_order_customer(order)
    @order = order
    attachments[@order.pdf_name] = @order.to_pdf
    mail(:subject => "Your order #{@order.id}", :to => @order.email)
  end

  def send_enquiry(message)
    @message = message
    mail(:subject => "New Enquiry - #{@message.id} - from #{@message.email}")
  end
end

