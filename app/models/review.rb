class Review < ApplicationRecord
  validates :rating, presence: true
  belongs_to :product
  belongs_to :purchase
  belongs_to :user

  enum rating: {
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
  }
end
