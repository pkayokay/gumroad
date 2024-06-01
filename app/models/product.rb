class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: -1 }
  belongs_to :user

  before_validation :autoset_slug, on: :create

  def autoset_slug
    self.slug = SecureRandom.alphanumeric(10)
  end
end
