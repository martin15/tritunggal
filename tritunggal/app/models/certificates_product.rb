class CertificatesProduct < ActiveRecord::Base
  belongs_to :certificate
  belongs_to :product
end
