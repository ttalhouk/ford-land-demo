class UsersController < ApplicationController
  # GET /users
  def index
    @user = current_user
    @services = @user.services
  end
end
