class AddBestSellerProduct < ActiveRecord::Migration
  def change
    add_column :products, :best_seller, :boolean
    remove_column :products, :certificate
  end
end
