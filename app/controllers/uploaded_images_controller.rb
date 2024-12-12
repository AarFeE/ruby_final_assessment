class UploadedImagesController < ApplicationController
  before_action :set_uploaded_image, only: %i[ show edit update destroy ]
  before_action :set_locale

  # GET /uploaded_images or /uploaded_images.json
  def index
    @uploaded_images = UploadedImage.all
  end

  # GET /uploaded_images/1 or /uploaded_images/1.json
  def show
  end

  # GET /uploaded_images/new
  def new
    @uploaded_image = UploadedImage.new
  end

  # GET /uploaded_images/1/edit
  def edit
  end

# POST /uploaded_images or /uploaded_images.json
def create
  @uploaded_image = UploadedImage.new(uploaded_image_params)

  if @uploaded_image.save
    Rails.logger.info "Saved uploaded image with ID: #{@uploaded_image.id}"
    if params[:uploaded_image][:image].present?
      begin
        @uploaded_image.upload_to_cloudinary(params[:uploaded_image][:image])
      rescue StandardError => e
        Rails.logger.error "Cloudinary upload failed: #{e.message}"
        @uploaded_image.errors.add(:base, "Cloudinary upload failed: #{e.message}")
      end
    end
    # Always redirect after the save process
    redirect_to uploaded_images_path, notice: "Uploaded image was successfully created."
  else
    Rails.logger.error "Failed to save uploaded image: #{@uploaded_image.errors.full_messages.join(', ')}"
    # Redirect even if save fails, just with a different notice
    redirect_to uploaded_images_path, alert: "Failed to create uploaded image. Please try again."
  end
end


  # PATCH/PUT /uploaded_images/1 or /uploaded_images/1.json
  def update
    respond_to do |format|
      if @uploaded_image.update(uploaded_image_params)
        format.html { redirect_to @uploaded_image, notice: "Uploaded image was successfully updated." }
        format.json { render :show, status: :ok, location: @uploaded_image }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("uploaded_image_#{@uploaded_image.id}", partial: "uploaded_images/uploaded_image", locals: { uploaded_image: @uploaded_image })
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @uploaded_image.errors, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("uploaded_image_form", partial: "uploaded_images/form", locals: { uploaded_image: @uploaded_image }) }
      end
    end
  end

  # DELETE /uploaded_images/1 or /uploaded_images/1.json
  def destroy
    @uploaded_image.destroy!

    respond_to do |format|
      format.html { redirect_to uploaded_images_path, status: :see_other, notice: "Uploaded image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uploaded_image
      @uploaded_image = UploadedImage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def uploaded_image_params
      params.require(:uploaded_image).permit(:title, :image)
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
end
