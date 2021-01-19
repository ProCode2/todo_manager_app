class TodosController < ApplicationController
  # show list of todos  (resource route)
  def index
    # filter todos
    @todos = current_user.todos
    render "index"
  end

  # create a new todo in the table  (resource route)
  def create
    todo_text = params[:todo_text]
    due_date = Date.parse(params[:due_date])
    new_todo = Todo.create!(
      todo_text: todo_text,
      due_date: due_date,
      completed: false,
      user_id: current_user.id,
    )

    redirect_to todos_path
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

    todo_to_be_updated = current_user.todos.find(id)
    todo_to_be_updated.completed = completed
    update_status = todo_to_be_updated.save
    # if updating the todo was a success
    if update_status
      redirect_to todos_path
    else
      #otherwise
      render plain: "Could not update your todo status"
    end
  end

  def destroy
    id = params[:id].to_i

    # if id is not an integer return with message
    if (id < 0)
      render plain: "Please provide an integer from 1 to #{Todo.count}"
      return
    end

    todo = current_user.todos.find(id)
    todo.destroy
    redirect_to todos_path
  end
end
