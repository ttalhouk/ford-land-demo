class PicturesController < ApplicationController
  helper :all
  before_action :check_admin_status, only: [:new, :destroy]
  before_action :set_item
  before_action :set_picture, only:[:destroy]

  def index
  end

  def new
  end

  def create
    @picture = @item.pictures.new(picture_params)
    if @picture.save
      format.html { redirect_to @item, notice: 'Picture was successfully added.' }
    else
      format.html { render :new }
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to @item, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private

  def set_item
    if params[:amenity_id]
      @item = Amenity.find(params[:amenity_id])
    elsif parmas[:property_id]
      @item = Property.find(params[:property_id])
    end
  end
  def set_picture
    @picture = Picture.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture.permit(:image))
  end
  def check_admin_status
    unless is_admin?
      flash[:error] = "You must be an Admin in to access this section"
      redirect_to root_path
    end
  end
end
