class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_parent_categories


  def paging(per_page)
    start_number = params[:page].nil? ? 0*per_page : (params[:page].to_i-1)*per_page
    return start_number
  end

  def the_domain
    host = request.host == "localhost" ? "#{request.host}:#{request.port}" : request.host
    return host
  end

  def get_parent_categories
    @categories = Category.parent_categories.includes([:child_categories])
  end

  def after_sign_in_path_for(resource)
    admin_path
  end
end
