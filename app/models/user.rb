class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  normalizes :email, with: ->(email) { email.strip.downcase }

  has_many :products, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :product_purchases, through: :products, source: :purchases
  has_many :followers, class_name: 'Follower', foreign_key: 'target_user_id', dependent: :destroy
  has_many :following_users, class_name: 'Follower', foreign_key: 'user_id', dependent: :destroy
  has_many :tips, class_name: 'Tip', foreign_key: 'target_user_id', dependent: :destroy
  has_many :creator_tips, class_name: 'Tip', foreign_key: 'user_id', dependent: :destroy
  has_many :wishlist_items

  before_validation :autoset_username, on: :create
  before_validation :autoset_avatar_url, on: :create

  def autoset_username
    self.username = SecureRandom.alphanumeric(10)
  end

  def autoset_avatar_url
    self.avatar_url = Faker::Avatar.image(size: "200x200", format: "jpg", set: "set#{rand(1..4)}", bgset: "bg#{rand(1..4)}")
  end

  def display_name
    name.presence || email
  end

  def initials
    display_name.first.capitalize
  end

  def followers_count
    followers.count
  end

  def sales_count
    products.sum {|p| p.sales_count }
  end

  def revenue_count
    products.sum {|p| p.revenue_count } + tips.sum {|t| t.amount.to_i }
  end
end
