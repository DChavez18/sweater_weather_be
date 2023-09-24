class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, confirmation: true, length: {minimum: 6}
  has_secure_password

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.hex
  end
end
