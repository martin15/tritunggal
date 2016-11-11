class Admin::ProductsController < Admin::ApplicationController
  before_filter :find_product, :only => [:edit, :update, :destroy, :delete]
  before_filter :validate_categories, :only => [:create, :update]
  before_filter :validate_certificates, :only => [:create, :update]

  def index
    @products = Product.order("#{sort_column} #{sort_direction}").page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @product = Product.new
    @p_categories = Category.parent_categories.includes([:child_categories])
    @product_image = @product.product_images.build
    @product_categories = []
    certificate_cat = CertificateCategory.all
    @option_for_certificate = []
    certificate_cat.each do |cat|
      certicates_temp = []
      cat.certificates.each do |certificate|
        certicates_temp << [certificate.name, certificate.id]
      end
      @option_for_certificate << [cat.name] + [certicates_temp]
    end
  end

  def create
    @product = Product.new(product_params)
    @product.categories = @categories
    @product.certificates = @certificates
    if @product.save
      params[:product_images]['image'].each do |a|
          @product_image = @product.product_images.create!(:image => a)
       end
      flash[:notice] = 'Product was successfully create.'
      redirect_to admin_products_path
    else
      @p_categories = Category.parent_categories.includes([:child_categories])
      flash[:error] = "Product failed to create"
      render :action => :new
    end
  end

  def edit
    @p_categories = Category.parent_categories.includes([:child_categories])
    @product_categories = @product.categories.map(&:id)
    certificate_cat = CertificateCategory.all
    @option_for_certificate = []
    certificate_cat.each do |cat|
      certicates_temp = []
      cat.certificates.each do |certificate|
        certicates_temp << [certificate.name, certificate.id]
      end
      @option_for_certificate << [cat.name] + [certicates_temp]
    end
    params[:certificates] = @product.certificates.map(&:id)
  end

  def update
    if @product.update_attributes(product_params)
      @product.categories = @categories
      @product.certificates = @certificates
      @product.save
      flash[:notice] = 'Product was successfully updated.'
      redirect_to admin_products_path
    else
      @p_categories = Category.parent_categories.includes([:child_categories])
      flash[:error] = "Product failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @product.destroy ? 'Product was successfully deleted.' :
                                           'Product was falied to delete.'
    redirect_to admin_products_path
  end

  def products_by_category
    @category = Category.find_by_permalink(params[:cat_permalink])
    if @category.nil?
      flash[:notice] = "Cannot find the Product with category '#{params[:cat_permalink]}'"
      redirect_to admin_products_path
    end
    @products = @category.products.order("#{sort_column} #{sort_direction}").page(params[:page]).per(20)
    @no = paging(20)
  end

  private

    def product_params
      params.require(:product).permit(:name, :sku, :short_specification, :specification,
                                      :certificate,
                                      :product_images_attributes =>[:id, :image, :product_id] )
    end

    def find_product
      @product = Product.find_by_id(params[:id])
      if @product.nil?
        flash[:notice] = "Cannot find the Product with id '#{params[:id]}'"
        redirect_to admin_products_path
      end
    end

    def validate_categories
      unless params[:category_ids].nil?
        @categories = Category.where("id in (?)", params[:category_ids])
      end
    end

    def validate_certificates
      unless params[:certificates].nil?
        @certificates = Certificate.where("id in (?)", params[:certificates])
      end
    end

    def sort_column
      params[:sort] || "created_at"
    end

    def sort_direction
      params[:direction] || "desc"
    end
end
