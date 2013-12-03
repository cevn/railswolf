class User < ActiveRecord::Base
  has_one :character, :dependent => :destroy


  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create :create_character 

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  has_secure_password

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
