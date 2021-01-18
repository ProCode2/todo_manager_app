class Todo < ApplicationRecord
  def to_formatted_string
    is_completed = completed ? "X" : " "
    "#{id}. #{due_date.to_s(:long)} #{todo_text} [#{is_completed}]"
  end

  def self.to_formatted_list
    all.map { |todo| todo.to_formatted_string }.join("\n")
  end
end
