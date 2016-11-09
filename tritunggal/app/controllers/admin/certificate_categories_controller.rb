class Admin::CertificateCategoriesController < Admin::ApplicationController
  before_filter :find_certificate, :only => [:edit, :update, :destroy, :delete]

  def index
    @certificate_categories = CertificateCategory.
                                order("#{sort_column} #{sort_direction}").page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @certificate_category = CertificateCategory.new
  end

  def create
    @certificate_category = CertificateCategory.new(certificate_params)
    if @certificate_category.save
      flash[:notice] = 'CertificateCategory was successfully create.'
      redirect_to admin_certificate_categories_path
    else
      flash[:error] = "CertificateCategory failed to create"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @certificate_category.update_attributes(certificate_params)
      flash[:notice] = 'CertificateCategory was successfully updated.'
      redirect_to admin_certificate_categories_path
    else
      flash[:error] = "CertificateCategory failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @certificate_category.destroy ? 'CertificateCategory was successfully deleted.' :
                                           'CertificateCategory was falied to delete.'
    redirect_to admin_certificate_categories_path
  end

  private

    def certificate_params
      params.require(:certificate_category).permit(:name)
    end

    def find_certificate
      @certificate_category = CertificateCategory.find_by_id(params[:id])
      if @certificate_category.nil?
        flash[:notice] = "Cannot find the CertificateCategory with id '#{params[:id]}'"
        redirect_to admin_certificate_categories_path
      end
    end

    def sort_column
      params[:sort] || "created_at"
    end

    def sort_direction
      params[:direction] || "desc"
    end
end