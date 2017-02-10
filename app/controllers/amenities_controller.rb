class AmenitiesController < ApplicationController
  helper :all
  before_action :check_admin_status, only: [:new, :edit, :update, :destroy]
  before_action :set_page
  before_action :set_amenity, only: [:show, :edit, :update, :destroy]

  # GET /amenities
  # GET /amenities.json
  def index
    @amenities = Amenity.all
  end

  # GET /amenities/1
  # GET /amenities/1.json
  def show
    @pictures = @amenity.pictures.all
  end

  # GET /amenities/new
  def new
    @amenity = Amenity.new
    @pictures = Picture.new
  end

  # GET /amenities/1/edit
  def edit
    @pictures = @amenity.pictures
  end

  # POST /amenities
  # POST /amenities.json
  def create
    input = amenity_params
    @amenity = Amenity.new({name: input['name'], description: input['description']})

    respond_to do |format|
      if @amenity.save
        @amenity.pictures.create(input['picture'])
        flash[:success] = 'Amenity was successfully created.'
        format.html { redirect_to @amenity}

      else
        flash[:error] = "There the following errors.  #{@amenity.errors.full_messages.join("")}"
        format.html { render :new }

      end
    end
  end

  # PATCH/PUT /amenities/1
  # PATCH/PUT /amenities/1.json
  def update
    input = amenity_params
    @amenity.pictures.create(input['picture'])

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

  # DELETE /amenities/1
  # DELETE /amenities/1.json
  def destroy
    @amenity.destroy
    respond_to do |format|
      flash[:success] =  'Amenity was successfully removed.'
      format.html { redirect_to amenities_url}
      format.json { head :no_content }
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
      @page = 'amenites'
    end

end
