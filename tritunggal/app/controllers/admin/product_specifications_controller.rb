class Admin::ProductSpecificationsController < Admin::ApplicationController
  before_filter :find_product, :only => [:index, :create, :edit, :update, :destroy, :delete]
  before_filter :find_product_specification, :only => [:edit, :update, :destroy, :delete]

  def index
    @product_specifications = @product.product_specifications.group_by{|h| h.file_type}
    @product_specification = ProductSpecification.new
  end

  def create
    @product_specification = ProductSpecification.new(product_specification_params)
    @product_specification.product = @product
    if @product_specification.save
      flash[:notice] = 'ProductSpecification was successfully create.'
      redirect_to admin_product_specifications_path
    else
      @product_specifications = @product.product_specifications.group_by{|h| h.file_type}
      flash[:error] = "ProductSpecification failed to create"
      render :action => :new
    end
  end

  def edit
    @product_specifications = @product.product_specifications.group_by{|h| h.file_type}
  end

  def update
    if @product_specification.update_attributes(product_specification_params)
      flash[:notice] = 'ProductSpecification was successfully updated.'
      redirect_to admin_product_specifications_path
    else
      @product_specifications = @product.product_specifications.group_by{|h| h.file_type}
      flash[:error] = "ProductSpecification failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @product_specification.destroy ? 'ProductSpecification was successfully deleted.' :
                                                       'ProductSpecification was falied to delete.'
    redirect_to admin_product_specifications_path
  end

  private

    def product_specification_params
      params.require(:product_specification).permit(:filename, :product_id)
    end

    def find_product
      @product = Product.find_by_id(params[:id])
      if @product.nil?
        flash[:notice] = "Cannot find the Product with id '#{params[:id]}'"
        redirect_to admin_products_path
      end
    end

    def find_product_specification
      @product_specification = ProductSpecification.find_by_id(params[:product_specification_id])
      if @product_specification.nil?
        flash[:notice] = "Cannot find the ProductSpecification with id '#{params[:product_specification_id]}'"
        redirect_to admin_product_specifications_path
      end
    end
end
