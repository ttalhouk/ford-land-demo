class Admin::UsersController < AdminController
  # GET /users
  def index
    @users = User.all.order(:id)
  end
end
