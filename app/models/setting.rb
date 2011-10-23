class Setting < ActiveRecord::Base
  validates :shipping_cost, :presence => true
  validates :free_shipping_threshold, :presence => true

  def self.shipping_cost
    self.first.shipping_cost
  end

  def self.free_shipping_threshold
    self.first.free_shipping_threshold
  end

end

