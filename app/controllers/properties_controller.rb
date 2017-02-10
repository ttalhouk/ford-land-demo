class PropertiesController < ApplicationController
  helper :all
  before_action :check_admin_status, only: [:new, :edit, :update, :destroy]
  before_action :set_page
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  # GET /properties
  # GET /properties.json
  def index
    if is_admin?
      @properties = Property.all
    else
      @properties = Property.where({available: true})
    end

  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @pictures = @property.pictures.all
  end

  # GET /properties/new
  def new
    @property = Property.new
    @pictures = Picture.new
  end

  # GET /properties/1/edit
  def edit
    @pictures = @property.pictures
  end

  # POST /properties
  # POST /properties.json
  def create
    input = property_params
    @property = Property.new({name: input['name'], description: input['description'], available: input['available']})

    respond_to do |format|
      if @property.save
        @property.pictures.create(input['picture'])
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    input = amenity_params
    @property.pictures.create(input['picture'])
    respond_to do |format|
      if @property.update({name: input['name'], description: input['description'], available: input['available']})
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:name, :description, {picture:['image','caption']}, :avaialable)
    end
    def check_admin_status
      unless is_admin?
        flash[:error] = "You must be an Admin in to access this section"
        redirect_to root_path
      end
    end
    def set_page
      @page = 'lease'
    end
end
