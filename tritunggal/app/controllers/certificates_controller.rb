class CertificatesController < ApplicationController
  def index
    @certificates = Certificate.all.group_by{|h| h.certificate_category_id}
    @certificate_categories = CertificateCategory.all.map{|x| {"#{x.id}" => x.name}}.reduce(:merge)
  end
end
