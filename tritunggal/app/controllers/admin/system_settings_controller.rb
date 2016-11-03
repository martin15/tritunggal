class Admin::SystemSettingsController < Admin::ApplicationController
  before_filter :find_system_setting, :only => [:edit, :update, :destroy, :delete]

  def index
    @system_settings = SystemSetting.order("#{sort_column} #{sort_direction}").page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @system_setting = SystemSetting.new
  end

  def create
    @system_setting = SystemSetting.new(system_setting_params)
    if @system_setting.save
      flash[:notice] = 'SystemSetting was successfully create.'
      redirect_to admin_path
    else
      flash[:error] = "SystemSetting failed to create"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @system_setting.update_attributes(system_setting_params)
      flash[:notice] = 'SystemSetting was successfully updated.'
      redirect_to admin_path
    else
      flash[:error] = "SystemSetting failed to update"
      render :action => :edit
    end
  end

  private

    def system_setting_params
      params.require(:system_setting).permit(:name, :value)
    end

    def find_system_setting
      @system_setting = SystemSetting.find_by_permalink(params[:id])
      if @system_setting.nil?
        flash[:notice] = "Cannot find the SystemSetting with name '#{params[:id]}'"
        redirect_to admin_path
      end
    end

    def sort_column
      params[:sort] || "created_at"
    end

    def sort_direction
      params[:direction] || "desc"
    end
end
