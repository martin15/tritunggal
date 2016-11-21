class CreateProductSpecifications < ActiveRecord::Migration
  def change
    create_table :product_specifications do |t|
      t.string  :filename
      t.string  :file_type
      t.integer :product_id
      t.timestamps null: false
    end
  end
end
