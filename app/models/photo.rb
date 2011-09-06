class Photo < ActiveRecord::Base
  has_attached_file :photo, :styles => { :big => "200x200>",:small => "112x112>",:thumb => "40x40>" },
                  :url  => "/assets/products/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"
  validates :product_id, :presence => true, :numericality => true

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
end
