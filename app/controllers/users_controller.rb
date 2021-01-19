class UsersController < ApplicationController
  def new
    render "users/new"
  end

  # register a new user to table (resource route)
  def create
    new_user = User.create!(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
    )
    redirect_to "/"
  end
end
