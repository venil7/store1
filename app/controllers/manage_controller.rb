class ManageController < ApplicationController
  layout "manage"
  #loggin
  before_filter :authenticate
  before_filter :product_reference_data, :only => [:add_product,:update_product, :add_photo]
  #products
  def products
    @page = params[:page] || 0
    @products = Product.page(@page).per(page_size)
  end

  def index
    redirect_to :action => :products
  end

  def add_product
    if request.get?
      @product = Product.new
    elsif request.post?
      @product = Product.new(params[:product])
      if @product.save
        redirect_to :action => :products
      end
    end
  end

  def update_product
    @product = Product.find(params[:id])
    @photo = @product.photos.new

    if request.put? and @product.update_attributes(params[:product])
      redirect_to :action => :products
    end
  end

  def delete_product
    Product.delete(params[:id])
    redirect_to :action => :products, :page => params[:page]
  end

  def add_photo
    @photo = Photo.new(params[:photo])
    if @photo.save
      redirect_to :action => :update_product, :id => @photo.product_id
    else
      @product = Product.find(@photo.product_id)
      render :action => :update_product
    end
  end

  def delete_photo
    @product_id = Photo.find(params[:id]).product_id
    Photo.delete(params[:id])
    redirect_to :action => :update_product, :id => @product_id
  end

  def orders
    @orders = Order.completed.page(@page).per(page_size)
  end

  def order_details
    @order = Order.find(params[:id])
  end

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == APP_CONFIG["admin_login"] && password == APP_CONFIG["admin_pass"]
    end
  end

  def product_reference_data
    default_dropdown_items = [['None','']]
    @categories = default_dropdown_items + Category.all.map {|c| [c.name, c.id]}
    @badges = default_dropdown_items + Badge.all.map {|b| [b.name, b.id]}
  end

  def page_size
    5
  end

end

