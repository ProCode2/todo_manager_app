class Todo < ApplicationRecord
  validates :todo_text, presence: true
  validates :todo_text, length: { minimum: 2 }
  validates :due_date, presence: true

  belongs_to :user

  def due_today?
    due_date == Date.today
  end

  def overdue?
    due_date < Date.today
  end

  def self.of_user(user_id)
    all.where(user_id: user_id)
  end

  # update status of an user's todo
  # using find_by_id instead of find because the former lets me silently check errors without throwing exceptions
  def self.update_todo(todo_id, completed, current_user)
    todo_to_be_updated = current_user.todos.find_by_id(todo_id)

    if !todo_to_be_updated
      return nil
    elsif todo_to_be_updated.overdue?
      # dilemma - should I use delete_todo, cause that'll make a db call again
      return delete_todo(todo_id, current_user)
    end


    todo_to_be_updated.completed = completed
    todo_to_be_updated.save
  end

  # delete a todo
  def self.delete_todo(todo_id, current_user)
    todo = current_user.todos.find_by_id(todo_id)
    if !todo
      return nil
    else
      todo.destroy
      todo.destroyed?
    end
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

  # show record validation errors
  def show_errors
    errors.full_messages.join(", ")
  end
end
