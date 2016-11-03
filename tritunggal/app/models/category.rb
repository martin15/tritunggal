class Category < ActiveRecord::Base
  has_permalink :name, :update => true

  has_many    :categories_products, :dependent => :destroy
  has_many    :child_categories, :class_name => "Category", :foreign_key => "parent_id"
  has_many    :products, :through => :categories_products, :dependent => :destroy

  belongs_to  :parent_category, :class_name => "Category", :foreign_key => "parent_id"

  validates :name, :presence => true

  scope :parent_categories, -> {where("parent_id IS NULL")}

  def is_parent?
    self.parent_id.nil?
  end

  def self.first_parent
    self.parent_categories.first
  end

  def first_child
    self.child_categories.first
  end

  def is_grandchild?
    parent = self.parent_category
    return false if parent.nil?
    grandpa = parent.parent_category
    return false if grandpa.nil?
    return true
  end

  def self.list_parent_categories
    self.parent_categories.map{|x| [x.name, x.id]}
  end

  def last_child?
    self.child_categories.blank?
  end

  def parent_and_grand_parent_id
    parent = self.parent_category
    return [] if parent.nil?
    grandpa = parent.parent_category
    return [parent.id] if grandpa.nil?
    return [grandpa.id, parent.id]
  end
end
