class CertificatesController < ApplicationController
  def index
    @certificate_umum = Certificate.where("certificate_type = 'Umum'").order("name")
    @certificate_teknik = Certificate.where("certificate_type = 'Teknik'").order("name")
  end
end
