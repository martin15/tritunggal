class Client < ActiveRecord::Base
  mount_uploader :logo, ClientLogoUploader

  validates :name, :presence => true
end
