class AddCategoryIdToCertificates < ActiveRecord::Migration
  def change
    remove_column :certificates, :certificate_type
    add_column :certificates, :certificate_category_id, :integer
  end
end
