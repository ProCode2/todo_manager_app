class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  # show list of todos  (resource route)
  def index
    render plain: Todo.all.order(:due_date).to_formatted_list
  end

  # show a single todo  (resource route)
  def show
    id = params[:id]

    # if id is not an integer return with message
    if (id.to_i == 0)
      render plain: "Please provide an integer from 1 to #{Todo.count}"
      return
    end

    todo = Todo.find(id)
    render plain: todo.to_formatted_string
  end

  # create a new todo in the table  (resource route)
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

  # update the completed status of a todo  (resource route)
  def update
    id = params[:id]
    completed = params[:completed]

    # if id is not an integer return with message
    if (id.to_i == 0)
      render plain: "Please provide an integer from 1 to #{Todo.count}"
      return
    end

    todo_to_be_updated = Todo.find(id)
    todo_to_be_updated.completed = completed
    update_status = todo_to_be_updated.save
    # if updating the todo was a success
    if update_status
      render plain: "Hey, the status of your todo with id #{id} is updated to #{completed}"
    else
      #otherwise
      render plain: "Could not update your todo status"
    end
  end
end
