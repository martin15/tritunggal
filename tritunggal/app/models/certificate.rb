class Certificate < ActiveRecord::Base
  has_permalink :name, :update => true

  mount_uploader :image, CertificateImageUploader
  mount_uploader :file, CertificateFileUploader
end
