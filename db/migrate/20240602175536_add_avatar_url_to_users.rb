class AddAvatarUrlToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :avatar_url, :string, null: false
  end
end
