class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.string  :sku
      t.text    :short_specification
      t.text    :specification
      t.text    :certificate
      t.float   :weight
      t.string  :permalink
      t.timestamps null: false
    end
  end
end
