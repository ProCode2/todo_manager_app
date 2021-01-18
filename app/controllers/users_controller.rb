class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  # render a list of users (resource route)
  def index
    render plain: User.all.order(:id).to_formatted_list
  end

  # register a new user to table (resource route)
  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]
    new_user = User.create!(
      name: name,
      email: email,
      password: password,
    )

    response = "Hey #{name}, You are registered successfully!"
    render plain: response
  end

  # check if uuser gave valid credentials
  def login
    email = params[:email]
    password = params[:password]
    render plain: User.check_credentials(email, password)
  end
end
