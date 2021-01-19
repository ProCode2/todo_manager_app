class User < ApplicationRecord
  has_many :todos
  has_secure_password
end
