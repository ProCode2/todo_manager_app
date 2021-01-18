class User < ApplicationRecord
  def to_formatted_string
    "#{id} #{name}"
  end

  def self.to_formatted_list
    all.map { |user| user.to_formatted_string }.join("\n")
  end

  def self.check_credentials(email, password)
    user = all.where("email = :email and password = :password", {
      email: email,
      password: password,
    }).first

    if !user
      return "false"
    else
      return "true"
    end
  end
end
