class Product < ActiveRecord::Base
  has_permalink :name, :update => true

  has_many :categories, :through => :categories_products, :dependent => :destroy
  has_many :categories_products, :dependent => :destroy
  has_many :certificates, :through => :certificates_products, :dependent => :destroy
  has_many :certificates_products, :dependent => :destroy
  has_many :product_images, :dependent => :destroy

  accepts_nested_attributes_for :product_images

  scope :best_seller, -> {where("best_seller = true")}

  def display_image
    self.product_images.first
  end

  def category
    self.categories.first
  end

end
