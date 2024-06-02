class AddImageUrlToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :image_url, :string, null: false
  end
end
