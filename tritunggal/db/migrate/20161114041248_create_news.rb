class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string  :title
      t.text    :content
      t.text    :short_content
      t.string  :user
      t.string  :permalink
      t.timestamps null: false
    end
  end
end
