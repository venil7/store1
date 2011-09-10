class Product < ActiveRecord::Base
  #links
  has_many :photos
  has_many :cartitems, :dependent => :destroy
  has_many :orders, :through => :cartitems

  belongs_to :category
  belongs_to :badge

  #validations
  validates_numericality_of :price
  validates_numericality_of :discount, :only_integer => true

  validates :name, :presence => true
  validates :sku, :presence => true, :uniqueness => true
  validates :category_id, :presence => true, :numericality => true
  validates :long_description, :presence => true
  validates :short_description, :presence => true

  scope :popular, order("updated_at")

  #virtual fields
  def final_price
    (discount ? price*(1-(discount*0.01)) : price).round(2)
  end

  def photo?
    if photos.any?
       @photo = photos.first.photo
       true
    else
       false
    end
  end

  def photo
    photo? ? @photo : nil
  end

  #helper functions
  def discount?
    (discount != nil) && (discount > 0)
  end
end

