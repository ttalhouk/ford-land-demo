class AdminController < ApplicationController
  # helper :all
  before_action :check_admin_status, :set_page
  layout 'admin/admin'
  # def index
  # end

  private
  def check_admin_status
    unless is_admin?
      flash[:error] = "You must be an Admin in to access this section"
      redirect_to root_path
    end
  end
  def set_page
    @page = 'admin'
  end
end
