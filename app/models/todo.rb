class Todo < ApplicationRecord
  def due_today?
    due_date == Date.today
  end

  # return all the todos that are overdue and not completed
  def self.overdue
    all.where("due_date < :date and completed = false ", { date: Date.today })
  end

  # return all the todos that are due today
  def self.due_today
    all.where(due_date: Date.today)
  end

  def self.completed
    all.where(completed: true)
  end

  # return all the todos that are due later
  def self.due_later
    all.where("due_date > :date", { date: Date.today })
  end
end
