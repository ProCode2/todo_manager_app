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

  # check if the email password combination exists on the table
  def self.check_credentials(email, password)
    user = all.where("email = :email and password = :password", {
      email: email,
      password: password,
    }).first

    # if an user was found
    if !user
      return "false"
    else
      # otheriwse
      return "true"
    end
  end
end
