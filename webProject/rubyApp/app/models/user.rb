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

  # VALID_EMAIL_REGEX = /^([0-9]{11}|[0-9]{10}|)$/i
  validates :phone_number,
            allow_blank: true,
            # format: { with: VALID_EMAIL_REGEX },
            length: { minimum: 10, maxium: 11 }

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
    n = self.phone_number
    if n < 1e10.to_i
      self.phone_number += 1e11.to_i unless n == 0
    end
  end

  def downcase_email
    self.email = email.downcase
  end
end
