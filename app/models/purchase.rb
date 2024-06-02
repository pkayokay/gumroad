class Purchase < ApplicationRecord
  validates :user_id, uniqueness: { scope: :product_id }

  belongs_to :follower
  belongs_to :user
  belongs_to :product
  has_one :review, dependent: :destroy
end
