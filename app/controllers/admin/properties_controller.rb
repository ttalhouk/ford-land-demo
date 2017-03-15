class Admin::PropertiesController < AdminController
  helper :all
  # before_action :check_admin_status, only: [:new, :edit, :update, :destroy]
  before_action :set_page
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  # GET /properties
  # GET /properties.json
  def index
      @properties = Property.all.order(:id)
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @pictures = @property.pictures.all
  end

  # GET /properties/new
  def new
    @property = Property.new
    @picture = Picture.new
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
        flash[:success] = 'Property was successfully created.'
        format.html { redirect_to admin_properties_path }
      else
        flash[:error] = "There the following errors.  #{@property.errors.full_messages.join("")}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    input = property_params
    respond_to do |format|
      if @property.update({name: input['name'], description: input['description'], available: input['available']})
        flash[:success] = 'Property was successfully updated.'
        format.html { redirect_to [:admin,@property]}
      else
        flash[:error] = "There the following errors.  #{@property.errors.full_messages.join("")}"
        format.html { render :edit }
      end
    end
  end
  def delete
    @property = Property.find(params[:property_id])
  end
  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @properties = Property.all.order(:id)
    # @property.destroy
    respond_to do |format|


      format.html do
        flash[:success] = 'Property was successfully removed.'
        redirect_to admin_properties_path
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
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:name, :description, {picture:['image','caption']}, :available)
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
