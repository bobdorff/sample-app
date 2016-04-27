class User < ActiveRecord::Base
  before_save do
    self.email.downcase!
  end
  EMAIL_VALIDATION = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:name,  presence: true, length: {maximum: 50})
  validates(:email, presence: true, length: {maximum: 200}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: {case_sensitive: false})
end
