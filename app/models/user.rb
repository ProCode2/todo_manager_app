class User < ApplicationRecord
  # validating input
  # restricting record creation without their presence
  has_secure_password
  validates :first_name, presence: true
  validates :email, presence: true

  has_many :todos

  # show record validation errors
  def show_errors
    errors.full_messages.join(", ")
  end
end
