class ProductsController < ApplicationController
  before_filter :find_category, :only => [:index, :show]
  before_filter :find_product, :only => [:show]

  def index
    order_by = params[:order_by].nil? ? "name" : params[:order_by]
    @products = @category.products.order(order_by).includes([:product_images]).page(params[:page]).per(12)
  end

  def show
    @product_images = @product.product_images
    @product_specifications = @product.product_specifications.group_by{|h| h.file_type}
    @certificates = @product.certificates
    @related_products = @category.products.sample(4)
  end

  def search
    @products = Product.where("name like '%#{params[:keyword]}%' OR sku like '%#{params[:keyword]}%'").
                       includes([:product_images]).page(params[:page]).per(12)
  end

  private
    def find_product
      @product = @category.products.find_by_permalink(params[:prod_permalink])
      if @product.nil?
        flash[:error] = "Cannot find product with name '#{params[:prod_permalink]}'"
        redirect_to products_path(@category.permalink)
      end
    end

    def find_category
      @category = Category.find_by_permalink(params[:cat_permalink])
      if @category.nil?
        flash[:error] = "Cannot find category with name '#{params[:cat_permalink]}'"
        redirect_to root_path
      end
    end
end
