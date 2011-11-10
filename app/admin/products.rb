ActiveAdmin.register Product do
  menu :parent => "Data"

  scope :discounted
  scope :non_discounted
  scope :recently_added
  scope :out_of_stock
  scope :in_stock

  index do
    column "id" do |p|
      span p.id
    end

    column "image" do |p|
      span link_to(image_tag(p.photo.url(:thumb)), edit_admin_product_path(p.id))
    end

    column "name" do |p|
      link_to(p.name, edit_admin_product_path(p.id))
    end

    column "photos" do |p|
      div link_to "photos", admin_product_path(p.id)
      div link_to "add photo", "#{new_admin_photo_path}?photo[product_id]=#{p.id}"
    end

    column "sku" do |p|
      span p.sku
    end

    column "price" do |p|
      span p.price
    end

    column "discount" do |p|
      span p.discount
      span "%"
    end

    column "final" do |p|
      span p.final_price
    end

    default_actions
  end


  show do
    h1 product.name
    h6 "product photos (first is default)"
    ul do
      product.photos.each do |f|
        #
        div image_tag(f.photo.url(:thumb))
        div link_to "delete", delete_admin_photo_path(f.id), {:method=>"delete", :confirm => "sure delete?"}
      end
    end

    link_to "add photo", "#{new_admin_photo_path}?photo[product_id]=#{product.id}"
  end

end

