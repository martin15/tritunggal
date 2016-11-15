class News < ActiveRecord::Base
  has_permalink :title, :update => true

  validates :title, :presence => true
end
