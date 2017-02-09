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
        format.html { redirect_to @amenity, notice: 'Amenity was successfully created.' }

      else
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
        format.html { redirect_to @amenity, notice: 'Amenity was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /amenities/1
  # DELETE /amenities/1.json
  def destroy
    @amenity.destroy
    respond_to do |format|
      format.html { redirect_to amenities_url, notice: 'Amenity was successfully destroyed.' }
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
      params.require(:amenity).permit(:name, :description, {picture:['image']})
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
