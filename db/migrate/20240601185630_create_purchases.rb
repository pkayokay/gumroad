class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: false }
      t.references :follower, null: false, foreign_key: true, index: { unique: false }
      t.references :product, null: false, foreign_key: true, index: { unique: false }
      t.integer :price, null: false

      t.timestamps
    end

    add_index :purchases, [:user_id, :product_id], unique: true
  end
end
