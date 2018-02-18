class Manage::ImagesController < Manage::ApplicationController
  load_and_authorize_resource
  inherit_resources

  belongs_to :project

  actions :destroy

  def create
    uploader = ImageUploader.new
    uploader.cache!(params[:file])

    image = @project.images.new(file: params[:file])

    respond_to do |format|
      if image.save
        format.json{ render json: { id: image.id, url: uploader.url } }
      else
        format.json{ render json: {}, status: :not_acceptable }
      end
    end
  end

  protected

  def permitted_params
    { image: params.fetch(:image, {}).permit(:file) }
  end

end