class AddUniqueIndexOnUserAndProductToWishlist < ActiveRecord::Migration[7.1]
  def change
    add_index :wishlist_items, [:user_id, :product_id], unique: true
  end
end