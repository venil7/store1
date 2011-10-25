ActiveAdmin.register Photo do
  menu false
  form :html => { :enctype => "multipart/form-data" } do |f|
      f.inputs "Photo", :multipart => true do
        f.input :description
        f.input :product_id, :input_html => { :readonly => true }
        f.input :photo
      end    
      f.buttons
    end
end

