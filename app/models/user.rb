class User < ApplicationRecord
  def to_formatted_string
    "#{id} #{name}"
  end

  def self.to_formatted_list
    all.map { |user| user.to_formatted_string }.join("\n")
  end
end
