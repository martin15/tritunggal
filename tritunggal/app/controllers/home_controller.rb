class HomeController < ApplicationController
  def index
    @banners = Banner.all
    @products = Product.best_seller
    @category = Category.first
  end
end
