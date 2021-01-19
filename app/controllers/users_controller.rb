class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  # register a new user to table (resource route)
  def create
    new_user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
    )
    if new_user.save
      session[:current_user_id] = new_user.id
    else
      flash[:error] = new_user.show_errors
    end
    redirect_to "/"
  end
end
