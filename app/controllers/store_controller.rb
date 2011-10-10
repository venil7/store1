class StoreController < CartController
  before_filter :set_reference_data

  def index
    @products = Product.page(@page).per(page_size)
    @slider_products = Product.with_badge :slider
  end

  def recent
    @menu_item = :recent
    @products = Product.recently_added.page(@page).per(page_size)
    render :action => :index
  end

  def sale
    @menu_item = :sale
    @products = Product.discounted.page(@page).per(page_size)
    render :action => :index
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
    else
     @menu_item = :cart
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
    @products = @category.products.page(@page).per(page_size)
  end

  def product
    @product = Product.find(params[:id])
  end

  #search
  def search
    if request.post?
      redirect_to :action => :search, :id => params[:search].strip
    else
      @products = Product.search(params[:id]).page(@page).per(page_size)
      render :action => :index
    end
  end

  private
  def page_size
    12
  end

  def set_reference_data
    @page = params[:page] || 0
    @cart = cart
    @categories = Category.limit(10)
    @popular = Product.popular.limit(10)
    @menu_item = :home
  end
end

