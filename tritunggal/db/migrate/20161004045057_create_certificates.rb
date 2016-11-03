class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string  :name
      t.text    :description
      t.string  :image
      t.string  :file
      t.string  :certificate_type
      t.string  :permalink
      t.timestamps null: false
    end
  end
end
