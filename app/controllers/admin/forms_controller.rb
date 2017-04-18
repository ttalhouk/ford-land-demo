class Admin::FormsController < AdminController
  helper :all
  before_action :set_page
  def index
    @form = Form.last || Form.new
    redirect_to admin_form_path(@form)
  end
  def show
    @form = Form.find(params[:id]) || Form.new
  end
  def create
    @form = Form.new
    if @form.save
      flash[:success] = 'Form was successfully created.'
      format.html { redirect_to forms_path}
    else
      flash[:error] = "Form was unable to be created and had the following errors. #{@form.errors.full_messages.join('')}"
      format.html { render :index }
    end
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
