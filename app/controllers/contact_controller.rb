class ContactController < ApplicationController
  def index
    @menu_item = :contact
    if request.post?
     @message = Message.new params[:message]
     if @message.valid?
      UserMailer.send_enquiry(@message).deliver
      redirect_to :action => :index
     else
      render :action => :index
     end
    else
     @message = Message.new
    end
  end
end

