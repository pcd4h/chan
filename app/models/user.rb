class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true

  validates :api_token, presence: true, uniqueness: true
  before_validation :generate_api_token

  def generate_api_token
    return if api_token.present?

    loop do
      self.api_token = SecureRandom.hex
      break unless User.exists? api_token: api_token
    end
  end
end
