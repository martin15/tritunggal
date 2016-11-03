module ApplicationHelper
  def flash_type(type)
     return 'danger' if type == 'alert'
     return 'danger' if type == 'error'
     return 'success' if type == 'notice'
  end

  def admin_active_menu(obj)
    return 'active' if controller_name == obj
  end

  def sortable(column, title=nil, type=nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
   link_to(title, :sort => column, :direction => direction)
  end

  def order_item
   [["Alphabetically : A-Z", "name"],
    ["Alphabetically : Z-A", "name desc"],
    ["Date : New to Old", "updated_at"],
    ["Date : Old to New", "updated_at desc"]]

  end

  def welcome_text
    str = ""
    if current_user.nil?
      str = str + "#{link_to raw("<i class='icon fa fa-user user' style='min-height:44px'></i> Login"),
                     new_user_session_path}"
      str = str + "#{link_to raw("<i class='icon fa fa-pencil-square-o'></i> Sign up"),
                                        new_user_registration_path}"
    else
      str = str + "#{link_to raw("<i class='icon fa fa-sign-out'></i> Sign Out"),
                             destroy_user_session_path, :method => :Delete}"
      str = str + "#{link_to raw("<i class='icon fa fa-user user'  style='min-height:44px'></i>
                                  #{current_user.first_name.titleize}
                                  #{current_user.last_name.titleize}"), admin_path}"
    end
  end

  def manage_banner
    current_user.nil? ? "normal" : "with-user-bar"
  end

  def manage_menu
    current_user.nil? ? "normal" : "with-user-bar"
  end
end
