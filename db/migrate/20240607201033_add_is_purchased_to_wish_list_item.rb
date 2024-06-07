class AddIsPurchasedToWishListItem < ActiveRecord::Migration[7.1]
  def change
    add_column :wishlist_items, :is_purchased, :boolean, default: false
  end
end
