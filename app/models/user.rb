class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  normalizes :email, with: ->(email) { email.strip.downcase }
end