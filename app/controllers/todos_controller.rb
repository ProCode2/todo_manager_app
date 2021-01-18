class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: Todo.all.order(:due_date).to_formatted_list
  end

  def show
    id = params[:id]
    todo = Todo.find(id)
    render plain: todo.to_formatted_string
  end

  def create
    todo_text = params[:todo_text]
    due_date = Date.parse(params[:due_date])
    new_todo = Todo.create!(
      todo_text: todo_text,
      due_date: due_date,
      completed: false,
    )

    response = "Hey, Your new todo is created with an id = #{new_todo.id}."
    render plain: response
  end

  def update
    id = params[:id]
    completed = params[:completed]

    todo_to_be_updated = Todo.find(id)
    todo_to_be_updated.completed = completed
    update_status = todo_to_be_updated.save
    if update_status
      render plain: "Hey, the status of your todo with id #{id} is updated to #{completed}"
    else
      render plain: "Could not update your todo status"
    end
  end
end
