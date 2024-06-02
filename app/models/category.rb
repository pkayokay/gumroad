class Category < ApplicationRecord
  validates :slug, uniqueness: true
end
