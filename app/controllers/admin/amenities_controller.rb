class Admin::AmenitiesController < AdminController
  helper :all
  # before_action :check_admin_status, only: [:new, :edit, :update, :destroy]
  before_action :set_page
  before_action :set_amenity, only: [:show, :edit, :update, :destroy]

  def index
    @amenities = Amenity.all.order(:id)
  end

  def show
    @pictures = @amenity.pictures.all
  end

  def new
    @amenity = Amenity.new
    @pictures = Picture.new
  end

  def edit
    @pictures = @amenity.pictures
  end

  def create
    input = amenity_params
    @amenity = Amenity.new({name: input['name'], description: input['description']})

    respond_to do |format|
      if @amenity.save
        @amenity.pictures.create(input['picture'])
        flash[:success] = 'Amenity was successfully created.'
        format.html do
          flash[:success] = 'Amenity was successfully created.'
          redirect_to admin_amenity_path(@amenity)
        end
      else
        flash[:error] = "There the following errors.  #{@amenity.errors.full_messages.join("")}"
        format.html { render :new }

      end
    end
  end

  def update
    input = amenity_params
    respond_to do |format|
      if @amenity.update({name: input['name'], description: input['description']})
        flash[:success] = 'Amenity was successfully updated.'
        format.html { redirect_to @amenity}
      else
        flash[:error] = "There the following errors.  #{@amenity.errors.full_messages.join("")}"
        format.html { render :edit }
      end
    end
  end

  def delete
    @amenity = Amenity.find(params[:amenity_id])
  end

  def destroy
    @amenities = Amenity.all.order(:id)
    @amenity.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Amenity was successfully removed.'
        redirect_to admin_amenities_path
      end
      format.json { head :no_content }
      format.js do
        flash.now[:success] = 'Property was successfully removed.'
        render :layout => false
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amenity
      @amenity = Amenity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amenity_params
      params.require(:amenity).permit(:name, :description, {picture:['image','caption']})
    end
    def check_admin_status
      unless is_admin?
        flash[:error] = "You must be an Admin in to access this section"
        redirect_to root_path
      end
    end
    def set_page
      @page = 'amenities'
    end

end
