class StoreController < CartController
  before_filter :set_reference_data

  def index
    @products = Product.all
  end

  #cart
  def clear
    clear_cart
    redirect_to request.referrer#:action => :index
  end

  def edit
    if request.post?
      @cart.update_amounts(request[:amounts])
      redirect_to :action => :edit
    end
  end

  def add
    add_to_cart(params[:id], params[:amount] || 1)
    redirect_to request.referrer#:action => :index
  end

  def delete
    delete_from_cart(params[:id])
    redirect_to request.referrer#:action => :index
  end

  #navigation
  def category
    @category = Category.find(params[:id])
    @page = params[:page] || 0
    @products = @category.products.page(@page).per(page_size)
  end

  def product
    @product = Product.find(params[:id])
  end

  private
  def page_size
    12
  end

  def set_reference_data
    @cart = cart
    @categories = Category.limit(10)
    @popular = Product.popular.limit(10)
  end
end

