class Admin::HomeController < AdminController
  def index
    # @amenities = Amenity.all
    # @gallery = Gallery.last || Gallery.new
    render :index
  end
  def preview
    render 'templates/preview.html'
  end

end
