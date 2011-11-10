ActiveAdmin.register Photo do
  menu :parent => "Data"

  index do
    column "id" do |p|
      span p.id
    end

    column "image" do |p|
      link_to(image_tag(p.photo.url(:thumb)), admin_photo_path(p.id))
    end

    column "name" do |p|
      link_to(p.photo_file_name, admin_photo_path(p.id))
    end

    column "Content/Type" do |p|
      span p.photo_content_type
    end

    default_actions
  end


  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Photo", :multipart => true do
      f.input :description
      f.input :product_id#, :input_html => { :readonly => true }
      f.input :photo
    end
    f.buttons
  end

  show do |f|
    h3 f.photo_file_name
    img :src => f.photo.url
  end

  member_action :delete, :method => :delete do
    photo = Photo.find(params[:id])
    photo.destroy
    redirect_to request.referrer, :notice => "Photo successfully destroyed"
  end
end

