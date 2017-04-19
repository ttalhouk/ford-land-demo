class FormsController < ApplicationController
  helper :all
  before_action :check_admin_status, only: [:create]
  before_action :set_page
  def index
    @form = Form.last || Form.create
    redirect_to form_path(@form)
  end
  def show
    @form = Form.find(params[:id]) || Form.new
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
