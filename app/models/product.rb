class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: -1 }
  belongs_to :user
  has_many :purchases, dependent: :destroy

  scope :published, -> { where(is_published: true) }

  before_validation :autoset_slug, on: :create

  def autoset_slug
    self.slug = SecureRandom.alphanumeric(10)
  end

  def sales_count
    purchases.count
  end

  def revenue_count
    purchases.sum {|p| p.price }
  end
end
