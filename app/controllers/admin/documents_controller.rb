class Admin::DocumentsController < AdminController
  helper :all
  before_action :check_admin_status, only: [:new, :destroy]
  before_action :set_item
  before_action :set_document, only:[:destroy]


  def new
    @document = Document.new
    p @document.doc
  end

  def create
    @document = @item.documents.new(document_params)
    respond_to do |format|
      if @document.save
        format.html { redirect_to @path, notice: 'Document was successfully added.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to @path, notice: 'Document was successfully destroyed.' }
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
    elsif params[:form_id]
      @item = Form.find(params[:form_id])
      @path = "/admin/forms/#{params[:form_id]}"
    end
  end
  def set_document
    @document = Document.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.require(:document).permit(:doc, :title)
  end
  def check_admin_status
    unless is_admin?
      flash[:error] = "You must be an Admin in to access this section"
      redirect_to root_path
    end
  end
end
