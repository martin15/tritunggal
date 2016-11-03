class SystemSetting < ActiveRecord::Base
  has_permalink :name, :update => true
end
