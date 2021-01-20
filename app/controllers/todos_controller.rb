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
    due_date = params[:due_date]
    new_todo = Todo.new(
      todo_text: todo_text,
      due_date: due_date,
      completed: false,
      user_id: current_user.id,
    )

    if !new_todo.save
      flash[:error] = new_todo.show_errors
    end
    redirect_to todos_path
  end

  # update the completed status of a todo  (resource route)
  def update
    id = params[:id].to_i
    completed = params[:completed]

    # if id is not an integer return with message
    if (id <= 0)
      flash[:error] = "Invalid Input"
      redirect_to todos_path
      return
    end

    update_status = Todo.update_todo(id, completed, current_user)
    # if updating the todo was a failure
    if !update_status
      flash[:error] = "Could not update todo at the moment."
    end
    redirect_to todos_path
  end

  def destroy
    id = params[:id].to_i

    # if id is not an integer return with message
    if (id <= 0)
      flash[:error] = "Invalid Input"
      redirect_to todos_path
      return
    end

    # delete a todo
    delete_status = Todo.delete_todo(id, current_user)
    if !delete_status
      flash[:error] = "Could not delete todo at the momment"
    end
    redirect_to todos_path
  end
end
