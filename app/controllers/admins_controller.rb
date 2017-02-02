class AdminsController < ApplicationController
  before_action :check_admin_status

  def index  
  end

  private
  def check_admin_status
    unless is_admin?
      flash[:error] = "You must be an Admin in to access this section"
      redirect_to root_path
    end
  end
end
