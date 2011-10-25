ActiveAdmin.register Product do
  menu :parent => "Data"

  scope :discounted
  scope :non_discounted
  scope :recently_added
  scope :out_of_stock
  scope :in_stock

  show do
    h3 product.name
    div product.price
    div product.discount
    div do
      simple_format product.long_description
    end


    ul do
      product.photos.each do |f|
        li image_tag f.photo.url(:thumb)
      end
    end

    link_to "add photo", "#{admin_photos_path}/new/?photo[product_id]=#{product.id}"

  end
end

