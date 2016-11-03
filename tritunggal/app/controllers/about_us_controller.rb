class AboutUsController < ApplicationController
  def index
    @about_us = SystemSetting.find_by_permalink("about-us")
  end
end
