class AboutUsController < ApplicationController
  def index
    @about_us = SystemSetting.find_by_permalink("about-us")
    @clients = Client.all
  end
end
