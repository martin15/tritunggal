class Certificate < ActiveRecord::Base
  belongs_to :certificate_category


  has_many :products, :through => :certificates_products, :dependent => :destroy
  has_many :certificates_products, :dependent => :destroy

  has_permalink :name, :update => true

  mount_uploader :image, CertificateImageUploader
  mount_uploader :file, CertificateFileUploader
end
