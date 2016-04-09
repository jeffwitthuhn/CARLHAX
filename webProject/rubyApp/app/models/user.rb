class User < ActiveRecord::Base
  before_save :downcase_email
  before_save :nationalize_phone_number
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6, maximum: 72 }

  validates :phone_number,
            length: { minimum: 10, maximum: 11 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest token
    Digest::SHA2.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.digest User.new_remember_token
  end

  def nationalize_phone_number
    self.phone_number += 10 ** 11 if self.phone_number.to_i > 10 ** 10
  end

  def downcase_email
    self.email = email.downcase
  end
end
