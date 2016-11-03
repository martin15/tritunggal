class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.string  :name
      t.text    :value
      t.string  :permalink
      t.timestamps null: false
    end
  end
end
