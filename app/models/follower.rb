class Follower < ApplicationRecord
  has_many :purchases, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :target_user, class_name: "User"

  def display_name
    user&.display_name || email
  end

  def revenue_count
    purchases.sum {|p| p.price }
  end
end
