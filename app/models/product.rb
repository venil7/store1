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

  default_scope order("price")
  scope :popular, order("updated_at") #requires review!!
  scope :discounted, where(:discount.gt => 0)
  scope :non_discounted, where({:discount => 0}|{:discount => nil})
  scope :with_badge, lambda {|badge| Product.joins(:badge).where('badges.name'=>badge)}
  scope :recently_added, where(:created_at.gte => 30.days.ago)
  scope :out_of_stock, where(:stock => 0)
  scope :in_stock, where(:stock.ne => 0)



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
    if photo?
       @photo
     else
      (Photo.find APP_CONFIG['no_image_id']).photo
     end
  end

  #helper functions
  def discount?
    (discount != nil) && (discount > 0)
  end

  def self.search(query)
    if !query.to_s.strip.empty?
       tokens = query.split.collect {|c| "%#{c.downcase}%"}
       #fields = [:name, :short_description, :long_description]
       meta = {:name.matches_any => tokens} |
              {:short_description.matches_any => tokens} |
              {:long_description.matches_any => tokens} |
              {:sku.matches_any => tokens}
       where(meta)
    else
      where(0)
    end
  end

end

