class HomeController < ApplicationController
  def index
    @banners = Banner.all
    @products = Product.all
  end
end
