class Admin::ProductImagesController < Admin::ApplicationController
  before_filter :find_product, :only => [:index, :create, :edit, :update, :destroy, :delete]
  before_filter :find_product_image, :only => [:edit, :update, :destroy, :delete]

  def index
    @product_images = @product.product_images
    @product_image = ProductImage.new
  end

  def create
    @product_image = ProductImage.new(product_image_params)
    @product_image.product = @product
    if @product_image.save
      flash[:notice] = 'ProductImage was successfully create.'
      redirect_to admin_product_images_path
    else
      flash[:error] = "ProductImage failed to create"
      render :action => :new
    end
  end

  def edit
    @product_images = @product.product_images
  end

  def update
    if @product_image.update_attributes(product_image_params)
      flash[:notice] = 'ProductImage was successfully updated.'
      redirect_to admin_product_images_path
    else
      flash[:error] = "ProductImage failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @product_image.destroy ? 'ProductImage was successfully deleted.' :
                                           'ProductImage was falied to delete.'
    redirect_to admin_product_images_path
  end

  private

    def product_image_params
      params.require(:product_image).permit(:image, :product_id, :is_primary)
    end

    def find_product
      @product = Product.find_by_id(params[:id])
      if @product.nil?
        flash[:notice] = "Cannot find the Product with id '#{params[:id]}'"
        redirect_to admin_products_path
      end
    end

    def find_product_image
      @product_image = ProductImage.find_by_id(params[:product_image_id])
      if @product_image.nil?
        flash[:notice] = "Cannot find the ProductImage with id '#{params[:product_image_id]}'"
        redirect_to admin_product_images_path
      end
    end
end
