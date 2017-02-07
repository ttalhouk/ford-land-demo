class ServicesController < ApplicationController
  # GET /users
  def index
    @user = current_user
    @services = @user.services
  end
end
