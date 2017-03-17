class GalleriesController < ApplicationController
  helper :all
  before_action :check_admin_status, only: [:create]
  before_action :set_page
  def index
    @gallery = Gallery.last || Gallery.new
    redirect_to admin_gallery_path(@gallery)
  end
  def show
    @gallery = Gallery.find(params[:id]) || Gallery.new
  end

  private

  def check_admin_status
    unless is_admin?
      flash[:error] = "You must be an Admin in to access this section"
      redirect_to root_path
    end
  end
  def set_page
    @page = 'gallery'
  end
end
