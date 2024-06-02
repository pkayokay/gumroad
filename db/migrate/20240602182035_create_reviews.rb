class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :rating, null: false
      t.references :product, null: false, foreign_key: true
      t.references :purchase, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
