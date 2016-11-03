class Product < ActiveRecord::Base
  has_permalink :name, :update => true

  has_many :categories, :through => :categories_products, :dependent => :destroy
  has_many :categories_products, :dependent => :destroy
  has_many :product_images, :dependent => :destroy

  accepts_nested_attributes_for :product_images

  def display_image
    self.product_images.first
  end

  def category
    self.categories.first
  end
end
