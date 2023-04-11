class User < ApplicationRecord
  before_save { self.email = email.strip.downcase }
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 8 }

  validates_uniqueness_of :email, case_sensitive: false

  def self.authenticate_with_credentials(email, password)
    normalized_email = email.strip.downcase

    user = User.find_by_email(normalized_email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
  
end
