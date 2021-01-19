class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  def create
    email = params[:email]
    user = User.find_by(email: email)
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to todos_path
    else
      redirect_to sessions_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
