class UserMailer < ActionMailer::Base
  default APP_CONFIG["mailer_default"].to_options
  helper :application

  def new_order_admin(order)
    @order = order
    mail(:subject => "Order #{@order.id}")
  end

  def new_order_customer(order, email)
    @order = order
    mail(:subject => "Your order #{@order.id}", :to => email)
  end

  def send_enquiry(message)
    @message = message
    mail(:subject => "New Enquiry")
  end
end

