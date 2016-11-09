class CertificateCategory < ActiveRecord::Base
  has_many :certificates

  validates :name, :presence => true

end
