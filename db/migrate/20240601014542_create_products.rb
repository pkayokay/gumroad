class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.integer :price, null: false, default: 0
      t.string :slug, null: false
      t.boolean :is_published, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :products, :slug, unique: true
    add_index :products, :is_published
  end
end
