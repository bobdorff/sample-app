class User < ActiveRecord::Base
  has_secure_password
  before_save do
    self.email.downcase!
  end
  EMAIL_VALIDATION = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:name,  presence: true, length: {maximum: 50})
  validates(:email, presence: true, length: {maximum: 200}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: {case_sensitive: false})
  validates(:password, :password_confirmation, presence: true, length: {minimum: 6})

  #creates a hash digest of a string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
