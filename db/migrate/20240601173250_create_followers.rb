class CreateFollowers < ActiveRecord::Migration[7.1]
  def change
    create_table :followers do |t|
      t.string :email, null: false
      t.references :user, foreign_key: true
      t.references :target_user, null: false, foreign_key: { to_table: :users }
      t.boolean :is_unsubscribed, null: false, default: false

      t.timestamps
    end
  end
end
