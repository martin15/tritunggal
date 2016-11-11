class CreateCertificatesProducts < ActiveRecord::Migration
  def change
    create_table :certificates_products do |t|
      t.string :certificate_id
      t.string :product_id
      t.timestamps null: false
    end
  end
end
