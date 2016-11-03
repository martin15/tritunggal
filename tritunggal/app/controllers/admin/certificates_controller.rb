class Admin::CertificatesController < Admin::ApplicationController
  before_filter :find_certificate, :only => [:edit, :update, :destroy, :delete]

  def index
    @certificates = Certificate.order("#{sort_column} #{sort_direction}").page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @certificate = Certificate.new
  end

  def create
    @certificate = Certificate.new(certificate_params)
    if @certificate.save
      flash[:notice] = 'Certificate was successfully create.'
      redirect_to admin_certificates_path
    else
      flash[:error] = "Certificate failed to create"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @certificate.update_attributes(certificate_params)
      flash[:notice] = 'Certificate was successfully updated.'
      redirect_to admin_certificates_path
    else
      flash[:error] = "Certificate failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @certificate.destroy ? 'Certificate was successfully deleted.' :
                                           'Certificate was falied to delete.'
    redirect_to admin_certificates_path
  end

  private

    def certificate_params
      params.require(:certificate).permit(:name, :description, :image, :file, :permalink, :certificate_type)
    end

    def find_certificate
      @certificate = Certificate.find_by_id(params[:id])
      if @certificate.nil?
        flash[:notice] = "Cannot find the Certificate with id '#{params[:id]}'"
        redirect_to admin_certificates_path
      end
    end

    def sort_column
      params[:sort] || "created_at"
    end

    def sort_direction
      params[:direction] || "desc"
    end
end
