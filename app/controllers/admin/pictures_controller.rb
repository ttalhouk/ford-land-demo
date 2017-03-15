class Admin::PicturesController < AdminController
  helper :all
  before_action :check_admin_status, only: [:new, :destroy]
  before_action :set_item
  before_action :set_picture, only:[:destroy]


  def new
    @picture = Picture.new
  end

  def create
    @picture = @item.pictures.new(picture_params)
    respond_to do |format|
      if @picture.save
        format.html { redirect_to @path, notice: 'Picture was successfully added.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to @path, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private

  def set_item
    if params[:amenity_id]
      @item = Amenity.find(params[:amenity_id])
      @path = "/admin/amenities/#{params[:amenity_id]}"
    elsif params[:property_id]
      @item = Property.find(params[:property_id])
      @path = "/admin/properties/#{params[:property_id]}"
    elsif params[:gallery_id]
      @item = Gallery.find(params[:gallery_id])
      @path = "/admin/galleries/#{params[:gallery_id]}"
    end
  end
  def set_picture
    @picture = Picture.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:image, :caption)
  end
  def check_admin_status
    unless is_admin?
      flash[:error] = "You must be an Admin in to access this section"
      redirect_to root_path
    end
  end
end
