class Admin::FormsController < AdminController
  helper :all
  before_action :set_page
  def index
    @form = Form.last || Form.create
  end

  def show
    redirect_to admin_forms_path
  end

  private

  def check_admin_status
    unless is_admin?
      flash[:error] = "You must be an Admin in to access this section"
      redirect_to root_path
    end
  end
  def set_page
    @page = 'form'
  end
end
