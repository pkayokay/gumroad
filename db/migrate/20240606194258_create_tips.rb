class CreateTips < ActiveRecord::Migration[7.1]
  def change
    create_table :tips do |t|
      t.string :email
      t.string :amount, null: false
      t.references :target_user, null: false, foreign_key: { to_table: :users }
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
