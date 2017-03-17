class Admin::GalleriesController < AdminController
  helper :all
  before_action :set_page
  def index
    @gallery = Gallery.last || Gallery.new
    redirect_to admin_gallery_path(@gallery)
  end
  def show
    @gallery = Gallery.find(params[:id]) || Gallery.new
  end
  def create
    @gallery = Gallery.new
    if @gallery.save
      flash[:success] = 'Gallery was successfully created.'
      format.html { redirect_to galleries_path}
    else
      flash[:error] = "Gallery was unable to be created and had the following errors. #{@gallery.errors.full_messages.join('')}"
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
    @page = 'gallery'
  end
end
