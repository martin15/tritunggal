class Admin::ContactUsController < Admin::ApplicationController
  before_filter :find_contact_us, :only => [:edit, :update, :destroy, :delete, :show]

  def index
    @contact_us_list = Contact.order("#{sort_column} #{sort_direction}").page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @contact_us = Contact.new
  end

  def create
    @contact_us = Contact.new(contact_us_params)
    if @contact_us.save
      flash[:notice] = 'Contact was successfully create.'
      redirect_to admin_contact_us_list_path
    else
      flash[:error] = "Contact failed to create"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @contact_us.update_attributes(contact_us_params)
      flash[:notice] = 'Contact was successfully updated.'
      redirect_to admin_contact_us_list_path
    else
      flash[:error] = "Contact failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @contact_us.destroy ? 'Contact was successfully deleted.' :
                                           'Contact was falied to delete.'
    redirect_to admin_contact_us_list_path
  end

  private

    def contact_us_params
      params.require(:contact_us).permit(:name, :description, :image, :file, :permalink)
    end

    def find_contact_us
      @contact_us = Contact.find_by_id(params[:id])
      if @contact_us.nil?
        flash[:notice] = "Cannot find the Contact with id '#{params[:id]}'"
        redirect_to admin_contact_us_list_path
      end
    end

    def sort_column
      params[:sort] || "created_at"
    end

    def sort_direction
      params[:direction] || "desc"
    end
end
