class Admin::UsersController < AdminController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order(:id)
  end

  def show

  end

  def edit

  end

  def update

    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to admin_users_path}
      else
        flash[:danger] = "There the following errors.  #{@amenity.errors.full_messages.join("")}"
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      flash[:success] =  'User was successfully removed.'
      format.html { redirect_to admin_users_path}
      format.json { head :no_content }
    end
  end

  private
  def user_params
    p params
    params.require(:user).permit(:email, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
