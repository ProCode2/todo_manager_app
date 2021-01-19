class Todo < ApplicationRecord
  belongs_to :user

  def due_today?
    due_date == Date.today
  end

  def self.of_user(user_id)
    all.where(user_id: user_id)
  end

  # return all the todos that are overdue and not completed
  def self.overdue
    all.where("due_date < :date and completed = false ", { date: Date.today }).order(:id)
  end

  # return all the todos that are due today
  def self.due_today
    all.where(due_date: Date.today).order(:id)
  end

  # return all comoleted todos
  def self.completed
    all.where(completed: true)
  end

  # return all the todos that are due later
  def self.due_later
    all.where("due_date > :date", { date: Date.today }).order(:id)
  end
end
