class ProductSpecification < ActiveRecord::Base
  mount_uploader :filename, ProductSpecificationUploader

  belongs_to :product

  before_save :add_file_type

  validates_presence_of :filename

  def add_file_type
    self.file_type = self.is_image? ?  "image" : "document"
  end

  def is_image?
    MIME::Types.type_for(self.filename.url).first.content_type.downcase.include?("image")
  end
end
