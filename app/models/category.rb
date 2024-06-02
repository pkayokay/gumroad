class Category < ApplicationRecord
  validates :slug, uniqueness: true
  has_many :product_categories, dependent: :destroy
end
