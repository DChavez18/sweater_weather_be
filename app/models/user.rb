class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, confirmantion: true, length: {minimum: 6}
  has_secure_password
end
