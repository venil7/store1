class Message < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :presence => true, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
  validates :message, :presence => true

end

