class User < ActiveRecord::Base
  has_secure_password
  has_many :questions

  validates :username, presence: true, length: { minimum: 6 }, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
end
