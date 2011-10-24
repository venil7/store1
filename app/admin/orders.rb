ActiveAdmin.register Order do
  menu :parent => "Data"

  scope :completed
  scope :shipped
end

