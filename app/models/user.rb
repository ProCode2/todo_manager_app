class User < ApplicationRecord
  has_many :todo
  has_secure_password

  # format user data to render on a page
  def to_formatted_string
    "#{id} #{name}"
  end

  # format a list of users to render on a page
  def self.to_formatted_list
    all.map { |user| user.to_formatted_string }.join("\n")
  end
end
