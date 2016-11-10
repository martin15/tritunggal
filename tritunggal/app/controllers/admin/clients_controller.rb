class Admin::ClientsController < Admin::ApplicationController
  before_filter :find_client, :only => [:edit, :update, :destroy, :delete]

  def index
    @clients = Client.order("#{sort_column} #{sort_direction}").page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:notice] = 'Client was successfully create.'
      redirect_to admin_clients_path
    else
      flash[:error] = "Client failed to create"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @client.update_attributes(client_params)
      flash[:notice] = 'Client was successfully updated.'
      redirect_to admin_clients_path
    else
      flash[:error] = "Client failed to update"
      render :action => :edit
    end
  end

  def destroy
    flash[:notice] =  @client.destroy ? 'Client was successfully deleted.' :
                                           'Client was falied to delete.'
    redirect_to admin_clients_path
  end

  private

    def client_params
      params.require(:client).permit(:name, :logo)
    end

    def find_client
      @client = Client.find_by_id(params[:id])
      if @client.nil?
        flash[:notice] = "Cannot find the Client with id '#{params[:id]}'"
        redirect_to admin_clients_path
      end
    end

    def sort_column
      params[:sort] || "created_at"
    end

    def sort_direction
      params[:direction] || "desc"
    end
end
