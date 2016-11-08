class HomeController < ApplicationController
  def index
    @banners = Banner.all
    @products = Product.all
    @category = Category.first
  end
end
