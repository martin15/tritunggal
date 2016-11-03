class Admin::CategoriesController < Admin::ApplicationController
  before_filter :find_category, :only => [:edit, :update, :destroy, :delete]

  def index
    @categories = Category.all.page(params[:page]).per(10)
    @no = paging(10)
  end

  def new
    unless params[:id].blank?
      find_category
    end
    @category = Category.new
  end

  def create
    @new_category = Category.new(category_params)
    unless params[:id].blank?
      find_category
      @new_category.parent_id = @category.id
    end

    if @new_category.save
      flash[:notice] = 'Category was successfully create.'
      redirect_to admin_categories_path
    else
      flash[:error] = "Category failed to create"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:notice] = 'Category was successfully updated.'
      redirect_to admin_categories_path
    else
      flash[:error] = "Category failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @category.destroy ? 'Category was successfully deleted.' :
                                           'Category was falied to delete.'
    redirect_to admin_categories_path
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

    def find_category
      @category = Category.find_by_id(params[:id])
      if @category.nil?
        flash[:notice] = "Cannot find the Category with id '#{params[:id]}'"
        redirect_to admin_categories_path
      end
    end
end
