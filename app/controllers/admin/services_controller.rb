class Admin::ServicesController < AdminController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :set_page

  def index
    Service.delete_old_records
    @services = Service.all.order(:id)
  end

  def show
  end


  def edit
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        ServiceMailer.service_response_email(current_user, @service.user, @service).deliver_now
        flash[:success] = 'Service Request was Successfully Updated'
        format.html {redirect_to admin_service_url(@service)}
      else
        flash[:error] = "There the following errors.  #{@service.errors.full_messages.join("")}"
        format.html { render :edit }
      end
    end
  end
  def delete
    @service = Service.find(params[:service_id])
  end

  def destroy
    @services = @services = Service.all.order(:id)
    @service.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Service Request was successfully removed.'
        redirect_to admin_services_path
      end
      format.json { head :no_content }
      format.js do
        flash.now[:success] = 'Service Request was successfully removed.'
        render :layout => false
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end
    def service_params
      params.require(:service).permit(:details, :open )
    end
    def set_page
      @page = "services"
    end
end
