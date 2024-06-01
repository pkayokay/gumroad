class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  normalizes :email, with: ->(email) { email.strip.downcase }

  has_many :products, dependent: :destroy

  before_validation :autoset_username, on: :create

  def autoset_username
    self.username = SecureRandom.alphanumeric(10)
  end

  def display_name
    name.presence || email
  end

  def initials
    display_name.first.capitalize
  end
end
