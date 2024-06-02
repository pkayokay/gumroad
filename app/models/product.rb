class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: -1 }
  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :product_category

  scope :published, -> { where(is_published: true) }

  before_validation :autoset_slug, on: :create
  before_validation :autoset_image_url, on: :create

  def autoset_slug
    self.slug = SecureRandom.alphanumeric(10)
  end

  def autoset_image_url
    self.image_url = Faker::Avatar.image(size: "400x400", format: "jpg", set: "set#{rand(1..4)}", bgset: "bg#{rand(1..4)}")
  end

  def sales_count
    purchases.count
  end

  def revenue_count
    purchases.sum {|p| p.price }
  end

  def ratings_average
    return nil unless reviews.exists?
    reviews.sum {|r| Review.ratings[r.rating] }  / reviews.count
  end
end
