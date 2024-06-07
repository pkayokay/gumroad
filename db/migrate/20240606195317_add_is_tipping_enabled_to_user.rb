class AddIsTippingEnabledToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_tipping_enabled, :boolean, null: false, default: true
  end
end
