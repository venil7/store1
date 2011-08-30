class Badge < ActiveRecord::Base
  has_many :products

  validates_presence_of :name
  validates_presence_of :description
end
