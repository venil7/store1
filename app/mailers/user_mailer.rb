class UserMailer < ActionMailer::Base
  default APP_CONFIG["mailer_default"].to_options

  def email(data)
   @data = data
   mail(:subject => "just a test really")
  end


  def notify_of_new_order(order)
    @order = order
    mail(:subject => "New Order")
  end

  def send_enquiry(message)
    @message = message
    mail(:subject => "New Enquiry")
  end
end

