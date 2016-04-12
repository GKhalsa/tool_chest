class User < ActiveRecord::Base
  has_secure_password
  has_many :tools
  validates :name, presence: true
  validates :username, presence: true
end
