class CreateCertificateCategories < ActiveRecord::Migration
  def change
    create_table :certificate_categories do |t|
      t.string  :name
      t.timestamps null: false
    end
  end
end
